from launch_ros.actions import Node

from launch import LaunchDescription
from launch.actions import DeclareLaunchArgument, GroupAction
from launch.conditions import IfCondition
from launch.substitutions import LaunchConfiguration, PythonExpression
from launch.event_handlers.on_process_start import OnProcessStart
import yaml
import os

def load_yaml_file(file_path):
    with open(file_path, 'r') as file:
        return yaml.safe_load(file)

def generate_launch_description():
    this_dir = os.path.dirname(os.path.abspath(__file__))

    config_file_path_angle = os.path.join(this_dir, '..', 'config', 'config_angle.yaml')
    config_file_path_position = os.path.join(this_dir, '..', 'config', 'config_position.yaml')

    config_angle = load_yaml_file(config_file_path_angle)
    config_position = load_yaml_file(config_file_path_position)

    mode = LaunchConfiguration('mode')
    
    mode_launch_arg = DeclareLaunchArgument(
        'mode',
        default_value="'position'",
        description='Mode of operation: angle or position'
    )

    position_nodes = []
    angle_nodes = []

    for node_position_config in config_position['nodes']:
        position_nodes.append(
            Node(
                package='marinero_parse',
                executable='mqtt_parse',
                name=node_position_config['name'],
                namespace=node_position_config['namespace'],
                output='screen',
                remappings=[
                    ('input_topic', '/' + node_position_config['remappings']['input_topic']),
                    ('output_topic_position', '/' + node_position_config['remappings']['output_topic_position']),
                    ('output_topic_angle', '/' + node_position_config['remappings']['output_topic_angle'])
                ]
            )
        )

    for node_angle_config in config_angle['nodes']:
        angle_nodes.append(
            Node(
                package='marinero_parse',
                executable='mqtt_parse_angle',
                name=node_angle_config['name'],
                namespace=node_angle_config['namespace'],
                output='screen',
                remappings=[
                    ('input_topic', '/' + node_angle_config['remappings']['input_topic']),
                    ('output_topic', '/' + node_angle_config['remappings']['output_topic'])
                ]
            )
        )

    load_nodes_position = GroupAction(
        condition=IfCondition(PythonExpression([mode,  " == 'position'"])),
        actions=position_nodes
    )

    load_nodes_angle = GroupAction(
        condition=IfCondition(PythonExpression([mode, " == 'angle'"])),
        actions=angle_nodes
    )

    return LaunchDescription([mode_launch_arg,
                             load_nodes_position,
                             load_nodes_angle])