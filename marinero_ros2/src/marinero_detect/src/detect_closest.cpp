#include <functional>
#include <vector>
#include <string>
#include <memory>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
#include "std_msgs/msg/float32.hpp"

class DetectClosest : public rclcpp::Node
{
  public:
    DetectClosest() : Node("detection_node")
    {
        auto topics = this->get_topic_names_and_types();

        for (const auto &topic : topics)
        {
            const std::string &topic_name = topic.first;

            size_t pos = topic_name.rfind("/");
            std::string tag_id = topic_name.substr(pos + 1);

            if (topic_name.find("/ros/angle") == 0)
            {
                RCLCPP_INFO(get_logger(), "Subscribing to topic: %s", topic_name.c_str());
                auto sub = this->create_subscription<std_msgs::msg::Float32>(
                    topic_name, 1, [this, tag_id](const std_msgs::msg::Float32::SharedPtr msg)
                    {
                        callback(msg, tag_id);
                    });
                subscriptions_.push_back(sub);
            }
        }
        publisher_ = this->create_publisher<std_msgs::msg::String>("/ros/closest_tag", 10);
    }

  private:
    void callback(const std_msgs::msg::Float32::SharedPtr msg, const std::string &tag_id)
    {
        calculateClosest(msg->data, tag_id, this->closest_tag_id);
        RCLCPP_INFO(get_logger(), "Publishing tag_id..");
        publisher_->publish(closest_tag_id);
    }
    void calculateClosest(const float &data, std::string tag_id, std_msgs::msg::String &tag_msg)
    {
        float difference = std::abs(data - 90);

        if (tag_msg.data == tag_id)
        {
            min_diff = difference;
            RCLCPP_INFO(get_logger(), "Closest tag remained the same.");
        }
        else
        {
            if (difference < min_diff)
            {
                tag_msg.data = tag_id;
                min_diff = difference;
                RCLCPP_INFO(get_logger(), "Closest tag changed. New closest: %s", tag_id.c_str());
            }
        }
    }

    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr publisher_;
    std::vector<rclcpp::Subscription<std_msgs::msg::Float32>::SharedPtr> subscriptions_;
    double min_diff = 1000.0;
    std_msgs::msg::String closest_tag_id;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  auto node = std::make_shared<DetectClosest>();
  rclcpp::spin(node);
  rclcpp::shutdown();
  return 0;
}