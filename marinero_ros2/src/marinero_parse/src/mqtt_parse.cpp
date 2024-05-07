#include <chrono>
#include <functional>
#include <memory>
#include <string>
#include <sstream>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
#include "geometry_msgs/msg/pose_stamped.hpp"

using namespace std::chrono_literals;

class MqttParse : public rclcpp::Node
{
  public:
    MqttParse() : Node("mqtt_parser")
    {
        publisher_ = this->create_publisher<geometry_msgs::msg::PoseStamped>("/position", 10);
        subscriber_ = this->create_subscription<std_msgs::msg::String>("topic", 10, std::bind(&MqttParse::subscriptionCallback, this, std::placeholders::_1));
    }

  private:
    void publish_position()
    {
        auto pose_msg = geometry_msgs::msg::PoseStamped();
        pose_msg.pose.position.x = 1.0;
        publisher_->publish(pose_msg);
    }
    void subscriptionCallback(const std_msgs::msg::String::SharedPtr msg)
    {
        auto pose_msg = geometry_msgs::msg::PoseStamped();
        if (parseStringToPose(msg->data, pose_msg))
        {
            RCLCPP_INFO(this->get_logger(), "Received pose message");
            publisher_->publish(pose_msg);
        }
        else
        {
            RCLCPP_WARN(this->get_logger(), "Failed to parse string into pose message");
        }
    }
    bool parseStringToPose(const std::string &str, geometry_msgs::msg::PoseStamped &pose)
    {
        std::istringstream iss(str);
        double x, y, z;
        if (!(iss >> x >> y >> z))
        {
            return false; // Parsing failed
        }
        //
        //nadodat parsing logiku tu
        //
        pose.pose.position.x = x;
        pose.pose.position.y = y;
        pose.pose.position.z = z;
        pose.header.stamp = this->now();
        pose.header.frame_id = "locator_frame";
        return true;
    }

    rclcpp::Publisher<geometry_msgs::msg::PoseStamped>::SharedPtr publisher_;
    rclcpp::Subscription<std_msgs::msg::String>::SharedPtr subscriber_;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  auto node = std::make_shared<MqttParse>();
  rclcpp::spin(node);
  rclcpp::shutdown();
  return 0;
}