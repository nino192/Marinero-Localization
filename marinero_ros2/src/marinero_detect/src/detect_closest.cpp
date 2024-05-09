#include <functional>
#include <memory>
#include <string>
#include <typeinfo>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
#include "geometry_msgs/msg/pose_stamped.hpp"

//ovo cu koristst samo ako ne uspijem smaknut detekciju unutar app.c

class DetectClosest : public rclcpp::Node
{
  public:
    DetectClosest() : Node("detection_node")
    {
        publisher_ = this->create_publisher<std_msgs::msg::String>(output_topic, 10);
        subscriber_ = this->create_subscription<geometry_msgs::msg::PoseStamped>(input_topic, 10, std::bind(&DetectClosest::subscriptionCallback, this, std::placeholders::_1));
    }

  private:
    void subscriptionCallback(const std_msgs::msg::String::SharedPtr msg)
    {
        auto pose_msg = geometry_msgs::msg::PoseStamped();
        if (calculateClosest(msg->data, pose_msg))
        {
            RCLCPP_INFO(this->get_logger(), "Received pose message");
            publisher_->publish(pose_msg);
        }
        else
        {
            RCLCPP_WARN(this->get_logger(), "Failed to parse string into pose message");
        }
    }
    bool calculateClosest(const std::string &str, geometry_msgs::msg::PoseStamped &pose)
    {
        rapidjson::Document document;
        document.Parse(str.c_str());

        if (document.HasParseError()){
            RCLCPP_ERROR(this->get_logger(), "Failed to parse JSON");
            return false;
        }

        if (!document.HasMember("x") || !document.HasMember("y") || !document.HasMember("z")) {
            RCLCPP_ERROR(this->get_logger(), "Missing required fields in JSON");
            return false;
        }
        pose.pose.position.x = document["x"].GetDouble();
        pose.pose.position.y = document["y"].GetDouble();
        pose.pose.position.z = document["z"].GetDouble();
        pose.header.stamp = this->now();
        pose.header.frame_id = "locator_link";
        return true;
    }

    rclcpp::Publisher<std_msgs::msg::String>::SharedPtr publisher_;
    rclcpp::Subscription<geometry_msgs::msg::PoseStamped>::SharedPtr subscriber_;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  auto node = std::make_shared<DetectClosest>();
  rclcpp::spin(node);
  rclcpp::shutdown();
  return 0;
}