# Copyright 2019 Intelligent Robotics Lab
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node


def generate_launch_description():
    # Get the launch directory
    example_dir = get_package_share_directory('planner')
    namespace = LaunchConfiguration('namespace')

    declare_namespace_cmd = DeclareLaunchArgument(
        'namespace',
        default_value='',
        description='Namespace')

    plansys2_cmd = IncludeLaunchDescription(
        PythonLaunchDescriptionSource(os.path.join(
            get_package_share_directory('plansys2_bringup'),
            'launch',
            'plansys2_bringup_launch_monolithic.py')),
        launch_arguments={
          'model_file': example_dir + '/pddl/domain2.pddl',
          'namespace': namespace
          }.items())

    # load_carrier_node
    # unload_carrier_node
    # move_carrier_node
    # load_supply_node
    # unload_bolt_node
    # unload_valve_node
    # unload_tool_node

    # Specify the actions
    load_carrier_cmd = Node(
        package='planner',
        executable='load_carrier_node',
        name='load_carrier_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    unload_carrier_cmd = Node(
        package='planner',
        executable='unload_carrier_node',
        name='unload_carrier_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    load_supply_cmd = Node(
        package='planner',
        executable='load_supply_node',
        name='load_supply_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    unload_valve_cmd = Node(
        package='planner',
        executable='unload_valve_node',
        name='unload_valve_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    
    unload_tool_cmd = Node(
        package='planner',
        executable='unload_tool_node',
        name='unload_tool_node',
        namespace=namespace,
        output='screen',
        parameters=[])

    unload_bolt_cmd = Node(
        package='planner',
        executable='unload_bolt_node',
        name='unload_bolt_node',
        namespace=namespace,
        output='screen',
        parameters=[])
    

    ld.add_action()

    # Declare the launch options
    ld.add_action(plansys2_cmd)

    ld.add_action(move_cmd)
    ld.add_action(charge_cmd)
    ld.add_action(ask_charge_cmd)

    return ld
