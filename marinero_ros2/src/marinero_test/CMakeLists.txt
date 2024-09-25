cmake_minimum_required(VERSION 3.8)
project(marinero_test)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)

add_executable(joystick_listener_node src/joystick_listener_node.cpp)

ament_target_dependencies(joystick_listener_node rclcpp sensor_msgs std_msgs)

install(TARGETS
  joystick_listener_node
  DESTINATION lib/${PROJECT_NAME})

ament_package()
