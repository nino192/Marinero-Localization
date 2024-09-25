#include "rclcpp/rclcpp.hpp"
#include "sensor_msgs/msg/joy.hpp"
#include "std_msgs/msg/header.hpp"

class JoystickListener : public rclcpp::Node
{
public:
  JoystickListener()
  : Node("joystick_listener"), button_previous_state_(0)
  {
    subscription_ = this->create_subscription<sensor_msgs::msg::Joy>(
      "/joy", 10, std::bind(&JoystickListener::joy_callback, this, std::placeholders::_1));
    publisher_ = this->create_publisher<std_msgs::msg::Header>("/identification_timestamp", 10);
  }

private:
  void joy_callback(const sensor_msgs::msg::Joy::SharedPtr msg)
  {
    // Check if the button (e.g., button 0) is pressed
    if (!msg->buttons.empty())
    {
      int button_current_state = msg->buttons[0];

      // Publish only if the button state changes from released (0) to pressed (1)
      if (button_current_state == 1 && button_previous_state_ == 0)
      {
        auto message = std_msgs::msg::Header();
        message.stamp = this->get_clock()->now();
        message.frame_id = "Identifikacija broda";
        RCLCPP_INFO(this->get_logger(), "Button pressed, publishing: '%s'", message.frame_id.c_str());
        publisher_->publish(message);
      }

      // Update the previous state of the button
      button_previous_state_ = button_current_state;
    }
  }

  rclcpp::Subscription<sensor_msgs::msg::Joy>::SharedPtr subscription_;
  rclcpp::Publisher<std_msgs::msg::Header>::SharedPtr publisher_;
  int button_previous_state_;
};

int main(int argc, char * argv[])
{
  rclcpp::init(argc, argv);
  rclcpp::spin(std::make_shared<JoystickListener>());
  rclcpp::shutdown();
  return 0;
}
