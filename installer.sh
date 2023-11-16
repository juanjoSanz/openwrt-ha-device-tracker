#!/bin/sh

echo " --- presence-detector installer ---- "

echo " Installing dependences ..."
opkg update && opkg install python3-light python3-urllib python3-idna python3-openssl

BASE_PATH="/etc/config/"

echo " Downloading presence-detector latest files ..."
wget https://raw.githubusercontent.com/rmoesbergen/openwrt-ha-device-tracker/main/init.d/presence-detector -O /etc/init.d/presence-detector
wget https://raw.githubusercontent.com/rmoesbergen/openwrt-ha-device-tracker/main/presence-detector.py -O ${BASE_PATH}/presence-detector.py
wget https://raw.githubusercontent.com/rmoesbergen/openwrt-ha-device-tracker/main/presence-detector.settings.json.example -O ${BASE_PATH}/presence-detector.settings.json.example

echo " Setting executable
chmod +x ${BASE_PATH}/presence-detector.py /etc/init.d/presence-detector

if [ -f ${BASE_PATH}/presence-detector.settings.json ]; then
   echo "Config file found ... it will be not overwritten"
else
   mv presence-detector.settings.json.example presence-detector.settings.json
   echo "Modify presence-detector.settings.json file !!!"
   vi ${BASE_PATH}/presence-detector.settings.json
fi

service presence-detector enable
service presence-detector start
