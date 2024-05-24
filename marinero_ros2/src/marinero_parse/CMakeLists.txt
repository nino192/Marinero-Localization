cmake_minimum_required(VERSION 3.8)
project(marinero_parse)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rcl_interfaces REQUIRED)
find_package(std_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(marinero_msgs REQUIRED)

include_directories(
  include
  ${rclcpp_INCLUDE_DIRS}
  ${std_msgs_INCLUDE_DIRS}
  ${geometry_msgs_INCLUDE_DIRS}
  ${marinero_msgs_INCLUDE_DIRS}
  ${rcl_interfaces_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable(mqtt_parse src/mqtt_parse.cpp)
add_executable(mqtt_parse_angle src/mqtt_parse_angle.cpp)
ament_target_dependencies(mqtt_parse rclcpp std_msgs geometry_msgs)
ament_target_dependencies(mqtt_parse_angle rclcpp std_msgs marinero_msgs)

install(TARGETS
  mqtt_parse
  mqtt_parse_angle
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
