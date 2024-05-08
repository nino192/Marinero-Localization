#include <chrono>
#include <functional>
#include <memory>
#include <string>
#include <typeinfo>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
#include "geometry_msgs/msg/pose_stamped.hpp"
#include "rapidjson/document.h"

using namespace std::chrono_literals;

class MqttParse : public rclcpp::Node
{
  public:
    MqttParse() : Node("mqtt_parser")
    {
        publisher_ = this->create_publisher<geometry_msgs::msg::PoseStamped>("/ros/position/ble_pd_804B5056BAA0", 10);
        subscriber_ = this->create_subscription<std_msgs::msg::String>("/position/ble_pd_804B5056BAA0", 10, std::bind(&MqttParse::subscriptionCallback, this, std::placeholders::_1));
    }

  private:
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