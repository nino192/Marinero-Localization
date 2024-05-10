cmake_minimum_required(VERSION 3.8)
project(marinero_detect)

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# find dependencies
find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(std_msgs REQUIRED)

include_directories(
  ${rclcpp_INCLUDE_DIRS}
  ${std_msgs_INCLUDE_DIRS}
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)

add_executable(detect_closest src/detect_closest.cpp)
ament_target_dependencies(detect_closest rclcpp std_msgs)

install(TARGETS
  detect_closest
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
