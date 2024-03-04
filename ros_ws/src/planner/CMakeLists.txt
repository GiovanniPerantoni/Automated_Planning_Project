cmake_minimum_required(VERSION 3.5)
project(planner)


find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(rclcpp_action REQUIRED)
find_package(plansys2_msgs REQUIRED)
find_package(plansys2_executor REQUIRED)

set(CMAKE_CXX_STANDARD 17)

set(dependencies
    rclcpp
    rclcpp_action
    plansys2_msgs
    plansys2_executor
)

add_executable(load_carrier_node src/load_carrier_node.cpp)
ament_target_dependencies(load_carrier_node ${dependencies})

add_executable(unload_carrier_node src/unload_carrier_node.cpp)
ament_target_dependencies(unload_carrier_node ${dependencies})

add_executable(load_supply_node src/load_supply_node.cpp)
ament_target_dependencies(load_supply_node ${dependencies})

add_executable(move_carrier_node src/move_carrier_node.cpp)
ament_target_dependencies(move_carrier_node ${dependencies})

add_executable(unload_bolt_node src/unload_bolt_node.cpp)
ament_target_dependencies(unload_bolt_node ${dependencies})

add_executable(unload_tool_node src/unload_tool_node.cpp)
ament_target_dependencies(unload_tool_node ${dependencies})

add_executable(unload_valve_node src/unload_valve_node.cpp)
ament_target_dependencies(unload_valve_node ${dependencies})

install(DIRECTORY launch pddl DESTINATION share/${PROJECT_NAME})

install(TARGETS
  load_carrier_node
  unload_carrier_node
  move_carrier_node
  load_supply_node
  unload_bolt_node
  unload_valve_node
  unload_tool_node
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION lib/${PROJECT_NAME}
)

if(BUILD_TESTING)
  find_package(ament_lint_auto REQUIRED)
  ament_lint_auto_find_test_dependencies()

  find_package(ament_cmake_gtest REQUIRED)
endif()

ament_export_dependencies(${dependencies})

ament_package()