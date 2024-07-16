# Marinero identification and localization
Code in this repo implements a single-anchor solution for identification and localization of ships in a marina using Bluetooth Low Energy technology. This code is intended to be used with the following hardware:
* BG22-PK6022A from *SiliconLabs*, as a BLE reciever: https://www.silabs.com/development-tools/wireless/bluetooth/bgm22-pro-kit?tab=overview
* BGM220-EK4314A from *SiliconLabs*, as a BLE transmitter: https://www.silabs.com/development-tools/wireless/bluetooth/bgm220-explorer-kit?tab=overview
The block diagram of this application is shown in the image below:
![blok-dijagram](https://github.com/user-attachments/assets/99051183-7484-49e9-87b9-68bd66aacce9)
## Repository components
### NCP_Host
### NCP_Target
This folder contains code intended to be flashed onto BG22-PK6022A. Code could be flashed by using either *SimplicityStudiov5* (https://www.silabs.com/developers/simplicity-studio) or by using a VSCode extension for flashing *SiliconLabs* boards (https://www.silabs.com/developers/simplicity-studio/visual-studio-code-plugin).
This code is the same as NCP_Target example in *SimplicityStudiov5*.
### SoC_Tag
This folder contains code intended to be flashed onto BGM220-EK4314A. Code could be flashed by using either *SimplicityStudiov5* (https://www.silabs.com/developers/simplicity-studio) or by using a VSCode extension for flashing *SiliconLabs* boards (https://www.silabs.com/developers/simplicity-studio/visual-studio-code-plugin).
This code is the same as NCP_Target example in *SimplicityStudiov5*.
### marinero_ros2
## Installation
## Usage
