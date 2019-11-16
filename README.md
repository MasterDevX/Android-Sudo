# Android-Sudo
Sudo installer for your Android device!
### Note
- This script is based on some shitcode, so I can not guarantee it will work on all devices, but it really should :P
- This script is not a rooting tool, it is just a wrapper for ```su``` binary, which allows you to run commands as root user using ```sudo``` command prefix, like you normally doing it on Linux distros.
- You need to have root privileges (```su``` binary) installed to use this script.
### Features
- Easy to install & use.
- Harmless.
- Ability to set password for ```sudo```.
### Installation
- Download ```installsudo.sh``` file and run it with root privileges: ```su -c ./installsudo.sh```
### Usage
- Once installed, you can ruun any command as root using: ```sudo <command>```. For example: ```sudo whoami``` will return ```root```.
