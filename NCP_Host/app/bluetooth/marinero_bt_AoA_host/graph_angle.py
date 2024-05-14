#!/usr/bin/python3

#graph angle test results - REQUIREMENT: marinero_locator_config.json reportMode = ANGLE

import argparse
import os
import re
import json
import sys

from pynput.keyboard import Listener, KeyCode
from matplotlib.lines import Line2D
import paho.mqtt.client as mqtt
import matplotlib.pyplot as plt
import numpy as np

DEFAULT_CONFIG = os.path.join(os.path.dirname(__file__), "config/marinero_locator_config.json")
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
        self.ang_list = []
        self.tags = {}
        self.counter = 0
        self.ref = 1

    def parse_config(self, config_file, iterations, mul):
        with open (config_file, 'r') as conf:
            conf = json.load(conf)
            if conf['reportMode'] in ['ANGLE', 'ANGLE_REPORT', 'ANGLEREPORT']:
                self.report_mode = 'ANGLE'
            else:
                raise ConfigError(f"reportMode must be set to ANGLE, not {self.report_mode}", self.report_mode)
        self.azimuth_masks = conf['azimuthMask']      
        self.elevation_masks = conf['elevationMask']  
        self.locator_id = 'ble-pd-0C4314F46B72'       #hardcoded
        self.iterations = iterations
        self.multi_reference = mul

    def plot_angle(self, data_list):
        fig = plt.figure()
        gs = fig.add_gridspec(2, 2)
        ax1 = fig.add_subplot(gs[0, 0])
        ax2 = fig.add_subplot(gs[0, 1])
        ax3 = fig.add_subplot(gs[1, :])

        #set reference test points
        azimuth_references = [-180, -135]#, -95, -70, -45, 0, 45, 70, 95, 135]
        elevation_references = [35, 20]#, 30, 40, 55, 70, 85, 25, 45, 90]
        distance_references = [2, 1]#, 1.5, 3, 3.5, 4, 2.8, 3.7, 3.2, 4.2]

        #error checking (if reference angles are in mask ranges)
        for element in self.azimuth_masks:
            for reference in azimuth_references:
                if reference > element['min'] and reference < element['max']:
                    raise ConfigError(f"Azimuth reference angle {reference} is inbetween the mask value.", reference)
        for element in self.elevation_masks:
            for reference in elevation_references:
                if reference > element['min'] and reference < element['max']:
                    raise ConfigError(f"Elevation reference angle {reference} is inbetween the mask value.", reference)

        #error checking (if num of reference angles are not equal to specified)
        if (len(azimuth_references) or len(elevation_references) or len(distance_references)) != self.multi_reference:
            raise ConfigError(f"Number of references is not equal to -mul specified ({self.multi_reference}).", self.multi_reference)
        
        for i in range(self.multi_reference):
            data_chunk = data_list[i * self.iterations:(i + 1) * self.iterations]
            for angle in data_chunk:
                azimuth = angle.get('azimuth')
                elevation = angle.get('elevation')
                distance = angle.get('distance')
                ax1.scatter(i + 1, azimuth, color='b', marker='_', s=100)
                ax2.scatter(i + 1, elevation, color='b', marker='_', s=100)   
                ax3.scatter(i + 1, distance, color='b', marker='o')
          
        ax1.step([i + 1 for i in range(len(azimuth_references))], azimuth_references, where='mid', color = 'r', linewidth=2)
        ax2.step([i + 1 for i in range(len(elevation_references))], elevation_references, where='mid', color = 'r', linewidth=2)
        ax3.step([i + 1 for i in range(len(distance_references))], distance_references, where='mid', color='r', linewidth=2)

        custom_legend_1 = [Line2D([0], [0], color='r', lw=2, label='ref_azimuth'),
                 Line2D([0], [0], color='b', lw=1, label='rec_azimuth')]
        
        custom_legend_2 = [Line2D([0], [0], color='r', lw=2, label='ref_elevation'),
                 Line2D([0], [0], color='b', lw=1, label='rec_elevation')]
        
        custom_legend_3 = [Line2D([0], [0], color='r', lw=2, label='ref_distance'),
                 Line2D([0], [0], color='b', marker='o', linestyle='None', label='rec_distance')]

        ax1.set_xlabel('Reference point number')
        ax1.set_ylabel('Azimuth(°)')
        ax1.set_xticks(np.arange(1, self.multi_reference + 1, 1))
        ax1.set_ylim(-180, 180)                     
        ax1.grid(True)
        ax1.legend(handles=custom_legend_1, loc='upper right')
        ax1.set_title('Azimuth Plot')

        ax2.set_xlabel('Reference point number')
        ax2.set_ylabel('Elevation(°)') 
        ax2.set_xticks(np.arange(1, self.multi_reference + 1, 1))
        ax2.set_ylim(0, 90)                         
        ax2.grid(True)
        ax2.legend(handles=custom_legend_2, loc='upper right')
        ax2.set_title('Elevation Plot')

        ax3.set_xlabel('Reference point number')
        ax3.set_ylabel('Distance(m)')
        ax3.set_xticks(np.arange(1, self.multi_reference + 1, 1))
        ax3.set_ylim(min(distance_references) - 0.5, max(distance_references) + 0.5) #set limit based on reference points!
        ax3.grid(True)
        ax3.legend(handles=custom_legend_3, loc='upper right')
        ax3.set_title('Distance Plot')

        plt.show()

        plt.savefig(os.path.join(os.path.dirname(__file__), "img/plot_ang.png"))

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
    if userdata.report_mode == 'ANGLE':
        m = re.match(r"silabs/aoa/angle/.+/(?P<tag_id>.+)", msg.topic)
        if m is not None:
            entry = json.loads(msg.payload)
            entry["tag_id"] = m.group("tag_id")
            userdata.update_ang(entry)
            userdata.counter += 1
            if userdata.counter >= userdata.iterations:
                userdata.counter = 0
                userdata.ref += 1
                if userdata.multi_reference <= (userdata.ref - 1):
                    userdata.plot_angle(userdata.ang_list)
                    client.loop_stop()
                    client.disconnect()
                    print('Disconnected')
                    sys.exit(0)
                client.disconnect()
                ######################################################## ovdje uvest nes pametnije od disconnecta?? ####################
    else:
        raise ConfigError(f"reportMode must be set to ANGLE, not {userdata.report_mode}", userdata.report_mode)

def on_connect(client, userdata, flags, rc, properties):
    ''' Called when a CONNACK response is received from the server. '''
    print("Connected with result code " + str(rc))
    if userdata.report_mode == 'ANGLE':
        topic = "silabs/aoa/angle/{}/#".format(userdata.locator_id)
        print("Subscribe for angle", topic)
        client.subscribe(topic)
    else:
        raise ConfigError(f"reportMode must be set to ANGLE, not {userdata.report_mode}", userdata.report_mode)

def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("-c", metavar="CONFIG_FILE", help="Configuration file path", default=DEFAULT_CONFIG)
    parser.add_argument("-m", metavar="HOST[:PORT]", help="MQTT broker connection parameters", default=DEFAULT_CONNECTION, type=mqtt_conn_type)
    parser.add_argument("-o", metavar="ITERATIONS", help="Number of data points at a reference", type=int)
    parser.add_argument("-mul", metavar="MULTI_REFERENCE", help="Number of reference points to gather data at", type=int, default=1)
    args = parser.parse_args()

    v = Visualizer()
    v.parse_config(args.c, args.o, args.mul)

    keyboard = Keyboard()

    mqttc = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2,userdata=v)
    mqttc.on_connect = on_connect
    mqttc.on_message = on_message

    mqttc.connect(host=args.m["host"], port=args.m["port"])

    mqttc.loop_forever()

    while True:
        print("Press 'n' for next reference point..")
        keyboard.wait('n')
        mqttc.connect(host=args.m["host"], port=args.m["port"])
        mqttc.loop_forever()

if __name__ == "__main__":
    main()