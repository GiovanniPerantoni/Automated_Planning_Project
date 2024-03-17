import os

from ament_index_python.packages import get_package_share_directory

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, IncludeLaunchDescription
from launch.launch_description_sources import PythonLaunchDescriptionSource
from launch.substitutions import LaunchConfiguration
from launch_ros.actions import Node

LOAD_CARRIER_DURATION = 1.0
UNLOAD_CARRIER_DURATION = 1.0
MOVE_CARRIER_DURATION = 5.0
LOAD_SUPPLY_DURATION = 2.0
UNLOAD_VALVE_DURATION = 2.0
UNLOAD_TOOL_DURATION = 2.0
UNLOAD_BOLT_DURATION = 2.0

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
            'model_file': example_dir + '/pddl/domain.pddl',
            'namespace': namespace,
            'params_file': get_package_share_directory('planner')+ '/params/params.yaml',
        }.items())

    # Specify the actions for robot1
    load_carrier1_cmd = Node(
        package='planner',
        executable='load_carrier_node',
        name='load_carrier_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": LOAD_CARRIER_DURATION
        }])

    unload_carrier1_cmd = Node(
        package='planner',
        executable='unload_carrier_node',
        name='unload_carrier_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_CARRIER_DURATION
        }])

    move_carrier1_cmd = Node(
        package='planner',
        executable='move_carrier_node',
        name='move_carrier_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": MOVE_CARRIER_DURATION
        }])

    load_supply1_cmd = Node(
        package='planner',
        executable='load_supply_node',
        name='load_supply_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": LOAD_SUPPLY_DURATION
        }])

    unload_valve1_cmd = Node(
        package='planner',
        executable='unload_valve_node',
        name='unload_valve_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_VALVE_DURATION
        }])

    unload_tool1_cmd = Node(
        package='planner',
        executable='unload_tool_node',
        name='unload_tool_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_TOOL_DURATION
        }])

    unload_bolt1_cmd = Node(
        package='planner',
        executable='unload_bolt_node',
        name='unload_bolt_node1',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_BOLT_DURATION
        }])

    ################################

    # Specify the actions for robot2
    load_carrier2_cmd = Node(
        package='planner',
        executable='load_carrier_node',
        name='load_carrier_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": LOAD_CARRIER_DURATION
        }])

    unload_carrier2_cmd = Node(
        package='planner',
        executable='unload_carrier_node',
        name='unload_carrier_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_CARRIER_DURATION
        }])

    move_carrier2_cmd = Node(
        package='planner',
        executable='move_carrier_node',
        name='move_carrier_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": MOVE_CARRIER_DURATION
        }])

    load_supply2_cmd = Node(
        package='planner',
        executable='load_supply_node',
        name='load_supply_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": LOAD_SUPPLY_DURATION
        }])

    unload_valve2_cmd = Node(
        package='planner',
        executable='unload_valve_node',
        name='unload_valve_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_VALVE_DURATION
        }])

    unload_tool2_cmd = Node(
        package='planner',
        executable='unload_tool_node',
        name='unload_tool_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_TOOL_DURATION
        }])

    unload_bolt2_cmd = Node(
        package='planner',
        executable='unload_bolt_node',
        name='unload_bolt_node2',
        namespace=namespace,
        output='screen',
        parameters=[{
            "duration": UNLOAD_BOLT_DURATION
        }])

    ld = LaunchDescription()

    ld.add_action(declare_namespace_cmd)
    # Declare the launch options
    ld.add_action(plansys2_cmd)

    # Add nodes for robot1
    ld.add_action(load_carrier1_cmd)
    ld.add_action(unload_carrier1_cmd)
    ld.add_action(move_carrier1_cmd)
    ld.add_action(load_supply1_cmd)
    ld.add_action(unload_valve1_cmd)
    ld.add_action(unload_tool1_cmd)
    ld.add_action(unload_bolt1_cmd)

    # Add nodes for robot2
    ld.add_action(load_carrier2_cmd)
    ld.add_action(unload_carrier2_cmd)
    ld.add_action(move_carrier2_cmd)
    ld.add_action(load_supply2_cmd)
    ld.add_action(unload_valve2_cmd)
    ld.add_action(unload_tool2_cmd)
    ld.add_action(unload_bolt2_cmd)

    return ld
