from launch import LaunchDescription
from launch_ros.actions import Node
import yaml
import os

def load_yaml_file(file_path):
    with open(file_path, 'r') as file:
        return yaml.safe_load(file)

def generate_launch_description():
    this_dir = os.path.dirname(os.path.abspath(__file__))
    config_file_path = os.path.join(this_dir, '..', 'config', 'config.yaml')
    config = load_yaml_file(config_file_path)

    nodes = []

    for node_config in config['nodes']:
        nodes.append(
            Node(
                package='marinero_parse',
                executable='mqtt_parse',
                name=node_config['name'],
                namespace=node_config['namespace'],
                output='screen',
                remappings=[
                    ('input_topic', '/' + node_config['remappings']['input_topic']),
                    ('output_topic', '/' + node_config['remappings']['output_topic'])
                ]
            )
        )
    
    return LaunchDescription(nodes)