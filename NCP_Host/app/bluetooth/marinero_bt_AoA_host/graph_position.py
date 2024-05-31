#!/usr/bin/python3

#graph angle test result plotter - REQUIREMENT: marinero_locator_config.json reportMode = POSITION

import argparse
import os
import re
import json
import sys

import paho.mqtt.client as mqtt
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import mpl_toolkits.mplot3d.art3d as art3d
import numpy as np

from pynput.keyboard import Listener, KeyCode
from math import sqrt

DEFAULT_CONFIG = os.path.join(os.path.dirname(__file__), "config/marinero_locator_config.json")
DEFAULT_REFERENCES = os.path.join(os.path.dirname(__file__), "config/references.json")
DEFAULT_CONNECTION = {"host": "localhost", "port": 1883}


class Keyboard:
    def __init__(self):
        pass

    def on_press(self, key):
        if key == KeyCode.from_char(self.key_to_wait):
            return False
    
    def wait(self, key):
        self.key_to_wait = key
        with Listener(on_press=self.on_press) as listener:
            listener.join()


class ConfigError(Exception):
    def __init__(self, message, value):
        self.message = message
        self.value = value
        super().__init__(message)


class Visualizer(object):
    def __init__(self):
        self.data = {}

    def parse_config(self, config_file, iterations, num):
        with open (config_file, 'r') as conf:
            conf = json.load(conf)
            if conf['reportMode'] in ['POSITION', 'POSITION_REPORT', 'POSITIONREPORT']:
                self.report_mode = 'POSITION'
            else:
                raise ConfigError(f"reportMode must be set to POSITION, not {conf['reportMode']}", conf['reportMode'])           
        self.locator_id = 'ble-pd-0C4314F46B72'       #hardcoded
        self.iterations = iterations
        self.num_tags = num

    def parse_references(self, reference_file):
        with open (reference_file, 'r') as ref:
            ref = json.load(ref)
        self.position_references = ref['position_references']
        self.colors = ref['colors']

    def plot_position(self, data_list, folder=None, filename=None):
        fig1 = plt.figure()
        fig2 = plt.figure()
        ax1 = fig1.add_subplot(1, 2, 1, projection='3d')
        ax2 = fig1.add_subplot(1, 2, 2)
        ax3 = fig2.add_subplot(1, 1, 1)

        legend_labels = []
        legend_colors = []

        #error checking (if num of reference positions is not equal to number of tags specified)
        if len(self.position_references) != self.num_tags:
            raise ConfigError(f"Number of references is not equal to -num of tags specified ({self.num_tags}).", self.num_tags)

        error_list = []

        for i, tag_list in enumerate(data_list.values()):
            color = self.colors[i]
            x_ref = self.position_references[i][0]
            y_ref = self.position_references[i][1]
            z_ref = self.position_references[i][2]
            for j in range(self.iterations):
                x = tag_list[j].get('x')
                y = tag_list[j].get('y')
                z = tag_list[j].get('z')
                compound = tag_list[j].get('compound_angle')
                ax1.scatter(x, y, z, color=color)

                #plot compound angle on a different plot
                compound_radians = np.radians(compound)
                slope = np.tan(compound_radians)
                y_values = np.linspace(-2.5, 2.5, 100)
                z_values = slope * y_values
                ax2.plot(y_values, z_values, color=color, linewidth=1)

                error = sqrt(((x - x_ref) ** 2) * ((y - y_ref) ** 2) * ((z - z_ref) ** 2))
                error_list.append(error)

            keys = list(data_list.keys())
            legend_labels.append(keys[i])
            legend_colors.append(color)

        #draw locator for reference
        p = patches.Rectangle((-0.5, -0.5), 1, 1, edgecolor='k', facecolor='k')
        ax1.add_patch(p)
        art3d.pathpatch_2d_to_3d(p, z=0, zdir="z")
        p = patches.Rectangle((-0.1, 0), 0.2, 0.05, linewidth=1, edgecolor='k', facecolor='k')
        ax2.add_patch(p)

        #draw true position of a tag
        for reference in self.position_references:
            ax1.scatter(reference[0], reference[1], reference[2], color='r', label='ref')
            ax2.scatter(reference[1], reference[2], color='r', label='ref')
        
        ##########CDF PLOT#########

        error_array = np.array(error_list)
        errors_array_sorted = np.sort(error_array)
        cdf_azimuth = np.arange(1, len(errors_array_sorted) + 1) / len(errors_array_sorted)
        ax3.plot(errors_array_sorted, cdf_azimuth, marker='.', linestyle='none')

        ###########################

        legend_labels.append('ref')
        legend_colors.append('r')
        custom_legend = [plt.Line2D([0], [0], marker='o', color='w', label=label,
                                     markerfacecolor=color, markersize=10) 
                         for label, color in zip(legend_labels, legend_colors)]

        ax1.set_title('Tag positions')
        ax1.set_xlabel('x (m)')
        ax1.set_ylabel('y (m)')
        ax1.set_zlabel('z (m)')
        ax1.set_xlim(-5, 5)                         #correspond to position reference list
        ax1.set_ylim(-5, 5)                         #correspond to position reference list
        ax1.set_zlim(0, 5)                          #correspond to position reference list

        ax2.set_title('Compound angle (top view)')
        ax2.set_xlabel('y (m)')
        ax2.set_ylabel('z (m)')
        ax2.set_xlim(-2.5, 2.5)                     #correspond to position reference list
        ax2.set_ylim(0, 5)                          #correspond to position reference list
        ax2.grid(True)

        ax3.set_xlabel('Error (m)')
        ax3.set_ylabel('Probability')
        ax3.set_title('CDF Position')
        ax3.grid(True)

        fig1.subplots_adjust(left=0.05, right=0.8)
        fig1.legend(handles=custom_legend, loc='upper left', bbox_to_anchor=(0.8, 0.5), title='Tags')

        plt.show()

        plt.savefig(os.path.join(os.path.dirname(__file__), "img/plot_pos.png"))

    def condition_met(self):
        for value in self.data.values():  
            if len(value) < self.iterations or len(self.data) < self.num_tags:
                return False
        return True

    def update_pos(self, tag_id, entry):
        if tag_id not in self.data:
            self.data[tag_id] = [entry]
        else:                                           
            self.data[tag_id].append(entry)


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
            tag_id = m.group("tag_id")
            entry = json.loads(msg.payload)
            userdata.update_pos(tag_id, entry)
            if userdata.condition_met():
                userdata.plot_position(userdata.data)
                client.disconnect()
                print('Disconnected')
                sys.exit(0)
    else:
        raise ConfigError(f"reportMode must be set to POSITION, not {userdata.report_mode}", userdata.report_mode)


def on_connect(client, userdata, flags, rc, properties):
    ''' Called when a CONNACK response is received from the server. '''
    print("Connected with result code " + str(rc))
    if userdata.report_mode == 'POSITION':
        topic = "silabs/aoa/position/{}/#".format(userdata.locator_id)
        print("Subscribe for pos", topic)
        client.subscribe(topic)
    else:
        raise ConfigError(f"reportMode must be set to POSITION, not {userdata.report_mode}", userdata.report_mode)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-c", metavar="CONFIG_FILE", help="Configuration file path", default=DEFAULT_CONFIG)
    parser.add_argument("-m", metavar="HOST[:PORT]", help="MQTT broker connection parameters", default=DEFAULT_CONNECTION, type=mqtt_conn_type)
    parser.add_argument("-o", metavar="ITERATIONS", help="Number of data points at a reference", type=int, default=10)
    parser.add_argument("-num", metavar="NUM_TAGS", help="Number of tags expected", type=int, default=1)
    parser.add_argument("-ref", metavar="REFERENCES_FILE", help="References file path", default=DEFAULT_REFERENCES)
    args = parser.parse_args()

    v = Visualizer()
    v.parse_config(args.c, args.o, args.num)
    v.parse_references(args.ref)

    keyboard = Keyboard()

    mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2,userdata=v)
    mqttc.on_connect = on_connect
    mqttc.on_message = on_message

    mqttc.connect(host=args.m["host"], port=args.m["port"])

    print("Press 's' to start test..")
    keyboard.wait('s')

    mqttc.loop_forever()


if __name__ == "__main__":
    main()