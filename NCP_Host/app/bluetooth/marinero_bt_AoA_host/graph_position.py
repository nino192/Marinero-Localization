#!/usr/bin/python3

#graph angle test results - REQUIREMENT: marinero_locator_config.json reportMode = POSITION

import argparse
import os
import re
import json
import random

import paho.mqtt.client as mqtt
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import mpl_toolkits.mplot3d.art3d as art3d

DEFAULT_CONFIG = os.path.join(os.path.dirname(__file__), "config/marinero_locator_config.json")
DEFAULT_CONNECTION = {"host": "localhost", "port": 1883}

class ConfigError(Exception):
    def __init__(self, message, value):
        self.message = message
        self.value = value
        super().__init__(message)

class Visualizer(object):
    def __init__(self):
        self.pos_list = []
        self.tags = {}
        self.counter = 0

    def parse_config(self, config_file, iterations):
        with open (config_file, 'r') as conf:
            conf = json.load(conf)
            if conf['reportMode'] in ['POSITION', 'POSITION_REPORT', 'POSITIONREPORT']:
                self.report_mode = 'POSITION'
            else:
                raise ConfigError(f"reportMode must be set to POSITION, not {self.report_mode}", self.report_mode)           
        self.locator_id = 'ble-pd-0C4314F46B72'       #hardcoded
        self.iterations = iterations

    def plot_position(self, data_list, folder=None, filename=None):
        fig = plt.figure()
        ax = fig.add_subplot(projection='3d')

        legend_labels = []
        legend_colors = []
        reference_pos = [[-0.7, -1.8, 2.0],[-0.7, 0.6, 0.8]]

        for tag in self.tags.values():
            clr = [random.random() for _ in range(3)]
            c = 0
            i = 0
            if self.iterations != None:                  #ako je setirana opcija -o > broj iteracija
                while c < self.iterations:
                    if tag == data_list[i]['tag_id']:
                        xs = data_list[i].get('x')
                        ys = data_list[i].get('y')
                        zs = data_list[i].get('z')
                        ax.scatter(xs, ys, zs, color=clr, label=tag)
                        c += 1
                    i += 1
            else:                                         #ako nije setirana opcija -o
                for data in data_list:
                    if tag == data['tag_id']:
                        xs = data.get('x')
                        ys = data.get('y')
                        zs = data.get('z')
                        ax.scatter(xs, ys, zs, color=clr, label=tag)
            legend_labels.append(tag)
            legend_colors.append(clr)

        #draw locator for reference
        p = patches.Rectangle((-0.5, -0.5), 1, 1, edgecolor='k', facecolor='k')
        ax.add_patch(p)
        art3d.pathpatch_2d_to_3d(p, z=0, zdir="z")

        #draw true position of a tag
        for reference in reference_pos:
            ax.scatter(reference[0], reference[1], reference[2], color='r', label='ref')
        legend_labels.append('ref')
        legend_colors.append('r')

        ax.set_xlabel('X Label')
        ax.set_ylabel('Y Label')
        ax.set_zlabel('Z Label')
        ax.set_xlim(-5, 5)
        ax.set_ylim(-5, 5)
        ax.set_zlim(0, 5)

        custom_legend = [plt.Line2D([0], [0], marker='o', color='w', label=label,
                                     markerfacecolor=color, markersize=10) 
                         for label, color in zip(legend_labels, legend_colors)]
        ax.legend(handles=custom_legend, loc='upper left', bbox_to_anchor=(1, 1), title='Tags')

        plt.show()

        plt.savefig(os.path.join(os.path.dirname(__file__), "img/plot_pos.png"))


    def update_pos(self, entry):
        self.pos_list.append(entry)
        if entry['tag_id'] not in self.tags.values():
            self.tags[f'tag_id_{self.counter}'] = entry['tag_id']
            self.counter += 1


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
            entry["tag_id"] = m.group("tag_id")
            userdata.update_pos(entry)
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


def on_disconnect(client, userdata, rc, properties=None, reason=None):
    if userdata.report_mode == 'POSITION':
        userdata.plot_position(userdata.pos_list)
    else:
        raise ConfigError(f"reportMode must be set to POSITION, not {userdata.report_mode}", userdata.report_mode)
    print('Disconnected')

def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-c", metavar="CONFIG_FILE", help="Configuration file path", default=DEFAULT_CONFIG)
    parser.add_argument("-m", metavar="HOST[:PORT]", help="MQTT broker connection parameters", default=DEFAULT_CONNECTION, type=mqtt_conn_type)
    parser.add_argument("-o", metavar="ITERATIONS", help="Number of data points to plot", type=int)
    args = parser.parse_args()

    v = Visualizer()
    v.parse_config(args.c, args.o)

    mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2,userdata=v)
    mqttc.on_connect = on_connect
    mqttc.on_message = on_message
    mqttc.on_disconnect = on_disconnect

    mqttc.connect(host=args.m["host"], port=args.m["port"])

    while True:
        try:
            mqttc.loop_forever()
        except KeyboardInterrupt:
            try:
                mqttc.disconnect()
                break
            except IndexError:
                print('Not enough data points, resetting..')
                plt.close()
                mqttc.connect(host=args.m["host"], port=args.m["port"])



if __name__ == "__main__":
    main()