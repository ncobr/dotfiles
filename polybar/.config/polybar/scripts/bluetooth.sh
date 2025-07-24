#!/bin/bash

# Check if bluetooth is enabled
if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
then
  echo " off"
else
  if [ $(echo "info" | bluetoothctl | grep 'Device' | wc -c) -eq 0 ]
  then 
    echo " on"
  else
    echo " $(echo "info" | bluetoothctl | grep 'Alias' | cut -d ' ' -f 2-)"
  fi
fi

# Toggle bluetooth
if [ "$1" == "--toggle" ]; then
  if [ $(bluetoothctl show | grep "Powered: yes" | wc -c) -eq 0 ]
  then
    bluetoothctl power on
  else
    bluetoothctl power off
  fi
fi
