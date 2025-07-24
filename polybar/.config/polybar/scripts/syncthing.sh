#!/bin/bash

# Check if syncthing is running
if [ $(pgrep syncthing | wc -l) -eq 0 ]; then
  echo " off"
else
  echo " on"
fi
