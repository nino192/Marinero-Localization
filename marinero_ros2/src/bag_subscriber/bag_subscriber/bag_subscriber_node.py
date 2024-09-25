import rclpy
from rclpy.node import Node
from geometry_msgs.msg import PoseStamped
from std_msgs.msg import String
from rclpy.qos import QoSProfile, QoSHistoryPolicy, QoSReliabilityPolicy

class BagSubscriberNode(Node):

    def __init__(self):
        super().__init__('bag_subscriber')

        qos_profile = QoSProfile(
            reliability=QoSReliabilityPolicy.RMW_QOS_POLICY_RELIABILITY_BEST_EFFORT,
            history=QoSHistoryPolicy.RMW_QOS_POLICY_HISTORY_KEEP_LAST,
            depth=10
        )

        self.pose_sub = self.create_subscription(
            PoseStamped,
            '/vrpn_mocap/Astro_bt/pose',
            self.pose_callback,
            qos_profile
        )
        self.tag_sub = self.create_subscription(
            String,
            '/ros/closest_tag',
            self.tag_callback,
            10
        )
        self.tag_data = None
        self.poses_with_tags = []

    def pose_callback(self, msg):
        if self.tag_data is not None:
            x = msg.pose.position.x
            y = msg.pose.position.y
            z = msg.pose.position.z
            tag = self.tag_data.data
            self.poses_with_tags.append((x, y, z, tag))

    def tag_callback(self, msg):
        self.tag_data = msg

    def save_to_file(self):
        filename = 'poses_with_tags.txt'
        with open(filename, 'w') as f:
            for pose in self.poses_with_tags:
                f.write(f'{pose[0]} {pose[1]} {pose[2]} {pose[3]}\n')
        self.get_logger().info(f'Saved poses with tags to {filename}')

    def shutdown_handler(self):
        self.save_to_file()
        self.destroy_node()
        rclpy.shutdown()

def main(args=None):
    rclpy.init(args=args)
    node = BagSubscriberNode()
    try:
        rclpy.spin(node)
    except KeyboardInterrupt:
        pass
    finally:
        node.shutdown_handler()

if __name__ == '__main__':
    main()
