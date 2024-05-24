#include <functional>
#include <memory>
#include <string>

#include "rclcpp/rclcpp.hpp"
#include "std_msgs/msg/string.hpp"
#include "marinero_msgs/msg/aoa.hpp"
#include "rapidjson/document.h"

class MqttParse : public rclcpp::Node
{
  public:
    MqttParse() : Node("mqtt_parser")
    {
        this->declare_parameter("input_topic", "input_topic");
        this->declare_parameter("output_topic", "output_topic");

        std::string input_topic = this->get_parameter("input_topic").as_string();
        std::string output_topic = this->get_parameter("output_topic").as_string();

        publisher_ = this->create_publisher<marinero_msgs::msg::Aoa>(output_topic, 10);
        subscriber_ = this->create_subscription<std_msgs::msg::String>(input_topic, 10, std::bind(&MqttParse::subscriptionCallback, this, std::placeholders::_1));
    }

  private:
    void subscriptionCallback(const std_msgs::msg::String::SharedPtr msg)
    {
        auto aoa_msg = marinero_msgs::msg::Aoa();
        if (parseStringToPose(msg->data, aoa_msg))
        {
            RCLCPP_INFO(this->get_logger(), "Received aoa message");
            publisher_->publish(aoa_msg);
        }
        else
        {
            RCLCPP_WARN(this->get_logger(), "Failed to parse string into aoa message");
        }
    }
    bool parseStringToPose(const std::string &str, marinero_msgs::msg::Aoa &aoa)
    {
        rapidjson::Document document;
        document.Parse(str.c_str());

        if (document.HasParseError()){
            RCLCPP_ERROR(this->get_logger(), "Failed to parse JSON");
            return false;
        }

        if (!document.HasMember("azimuth") || !document.HasMember("elevation") || !document.HasMember("distance")) {
            RCLCPP_ERROR(this->get_logger(), "Missing required fields in JSON");
            return false;
        }
        aoa.distance = document["distance"].GetDouble();
        aoa.azimuth = document["azimuth"].GetDouble();
        aoa.elevation = document["elevation"].GetDouble();
        return true;
    }

    rclcpp::Publisher<marinero_msgs::msg::Aoa>::SharedPtr publisher_;
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