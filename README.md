# Marinero identification and localization
Code in this repo implements a single-anchor solution for identification and localization of ships in a marina using Bluetooth Low Energy technology. This code is intended to be used with the following hardware:
* BG22-PK6022A from *SiliconLabs*, as a BLE reciever: https://www.silabs.com/development-tools/wireless/bluetooth/bgm22-pro-kit?tab=overview
* BGM220-EK4314A from *SiliconLabs*, as a BLE transmitter: https://www.silabs.com/development-tools/wireless/bluetooth/bgm220-explorer-kit?tab=overview

The block diagram of this application is shown in the image below:

![image](https://github.com/user-attachments/assets/97e0ccd1-e268-4fac-b019-44ee28672ec9)
## Repository components
### NCP_Host
This folder contains code intended to be run on Host PC. Marinero_bt_AoA_host is an application similar to bt_aoa_host_locator but with added marinero_distance.c and marinero_positioning.c. Marinero_distance.c contains function *calculate_avg_rssi* for RSSI filtering in real-time and function *marinero_calculate_distance* for distance calculation using RSSI.
### NCP_Target
This folder contains code intended to be flashed onto BG22-PK6022A. Code could be flashed by using either *SimplicityStudiov5* (https://www.silabs.com/developers/simplicity-studio) or by using a VSCode extension for flashing *SiliconLabs* boards (https://www.silabs.com/developers/simplicity-studio/visual-studio-code-plugin).
This code is the same as NCP_Target example in *SimplicityStudiov5*.
### SoC_Tag
This folder contains code intended to be flashed onto BGM220-EK4314A. Code could be flashed by using either *SimplicityStudiov5* (https://www.silabs.com/developers/simplicity-studio) or by using a VSCode extension for flashing *SiliconLabs* boards (https://www.silabs.com/developers/simplicity-studio/visual-studio-code-plugin).
This code is the same as SoC_Tag example in *SimplicityStudiov5*.
### marinero_ros2
This folder contains ros2 integration of said application. Package marinero_parse contains parsers for converting data into ros2 standard messages, marinero_launch contains a launchfile for the parsers, marinero_detect contains a node that identifies the nearest ship and marinero_msgs contains a custom AoA ros message. Mqtt_params package contains a .yaml files for configuring mqtt2ros2 bridge (https://github.com/ika-rwth-aachen/mqtt_client).

Ros2 package structure is shown in the diagram below:

![image](https://github.com/user-attachments/assets/b3493f95-6a79-49c5-b2ce-1fdda0edf24a)


## Installation
Requirements:

## Usage

## Configuration files
