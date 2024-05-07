cmake_minimum_required(VERSION 3.8)
project(marinero_parse)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)

add_executable(mqtt_parse src/mqtt_parse.cpp)
ament_target_dependencies(mqtt_parse rclcpp std_msgs geometry_msgs)

install(TARGETS
  mqtt_parse
  DESTINATION lib/${PROJECT_NAME})

ament_package()
