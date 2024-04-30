#!/usr/bin/python3

#graph test results

import argparse
import os
import re
import json

import paho.mqtt.client as mqtt
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import mpl_toolkits.mplot3d.art3d as art3d
import numpy as np

DEFAULT_CONFIG = os.path.join(os.path.dirname(__file__), "config/marinero_locator_config.json")
DEFAULT_CONNECTION = {"host": "localhost", "port": 1883}

class Visualizer(object):
    def __init__(self):
        self.pos_list = []
        self.ang_list = []
        self.tags = {}

    def parse_config(self, config_file):
        with open (config_file, 'r') as conf:
            conf = json.load(conf)
            if conf['reportMode'] == 'POSITION' or 'POSITION_REPORT' or 'POSITIONREPORT':
                self.report_mode = 'POSITION'
            elif conf['reportMode'] == 'ANGLE' or 'ANGLE_REPORT' or 'ANGLEREPORT':
                self.report_mode = 'ANGLE'
            else:
                self.report_mode = 'IQ'                        
        self.locator_id = 'ble-pd-0C4314F46B72'       #hardcoded

    def plot_position(self, data_list, folder=None, filename=None):
        fig = plt.figure()
        ax = fig.add_subplot(projection='3d')
        for position in data_list:
            xs = position.get('x')
            ys = position.get('y')
            zs = position.get('z')
            ax.scatter(xs, ys, zs)
        #draw locator for reference
        p = patches.Rectangle((0, 0), 1, 1, edgecolor='k', facecolor='k')
        ax.add_patch(p)
        art3d.pathpatch_2d_to_3d(p, z=0, zdir="z")

        ax.set_xlabel('X Label')
        ax.set_ylabel('Y Label')
        ax.set_zlabel('Z Label')
        ax.set_xlim(-5, 5)
        ax.set_ylim(-5, 5)
        ax.set_zlim(0, 5)

        plt.show()

        plt.savefig(os.path.join(os.path.dirname(__file__), "img/plot.png"))

    #def plot_angle(self, data_list):


    def update_pos(self, entry):
        self.pos_list.append(entry)
    
    def update_ang(self,entry):
        self.ang_list.append(entry)       


def mqtt_conn_type(arg):
    """ Argument parser for MQTT server connection parameters. """
    retval = DEFAULT_CONNECTION
    arglist = arg.split(":", 1)
    if len(arglist[0]) == 0:
        raise argparse.ArgumentTypeError("Host name is empty")
    retval["host"] = arglist[0]
    if len(arglist) > 1:
        try:
            retval["port"] = int(arglist[1])
        except ValueError as val:
            raise argparse.ArgumentTypeError("Invalid port number: " + arglist[1]) from val
    return retval

def on_message(client, userdata, msg):
    ''' Called when a PUBLISH message is received from the server. '''
    if userdata.report_mode == 'POSITION':
        m = re.match(r"silabs/aoa/position/.+/(?P<tag_id>.+)", msg.topic)
        if m is not None:
            entry = json.loads(msg.payload)
            userdata.update_pos(entry)
    if userdata.report_mode == 'ANGLE':
        m = re.match(r"silabs/aoa/angle/.+/(?P<tag_id>.+)", msg.topic)
        if m is not None:
            entry = json.loads(msg.payload)
            userdata.update_ang(entry)

def on_connect(client, userdata, flags, rc, properties):
    ''' Called when a CONNACK response is received from the server. '''
    print("Connected with result code " + str(rc))
    if userdata.report_mode == 'POSITION':
        topic = "silabs/aoa/position/{}/#".format(userdata.locator_id)
        print("Subscribe for ", topic)
        client.subscribe(topic)
    if userdata.report_mode == 'ANGLE':
        topic = "silabs/aoa/angle/{}/#".format(userdata.locator_id)
        print("Subscribe for ", topic)
        client.subscribe(topic)

def on_disconnect(client, userdata, rc, properties=None, reason=None):
    userdata.plot_position(userdata.pos_list)
    print('Disconnected')

def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-c", metavar="CONFIG_FILE", help="Configuration file path", default=DEFAULT_CONFIG)
    parser.add_argument("-m", metavar="HOST[:PORT]", help="MQTT broker connection parameters", default=DEFAULT_CONNECTION, type=mqtt_conn_type)
    args = parser.parse_args()

    v = Visualizer()
    v.parse_config(args.c)

    mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2,userdata=v)
    mqttc.on_connect = on_connect
    mqttc.on_message = on_message
    mqttc.on_disconnect = on_disconnect

    mqttc.connect(host=args.m["host"], port=args.m["port"])

    try:
        mqttc.loop_forever()
    except KeyboardInterrupt:
        mqttc.disconnect()

if __name__ == "__main__":
    main()