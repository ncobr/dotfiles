#!/bin/bash

# Set keyboard layout
setxkbmap -layout latam &

# Start XFCE services in the background
/usr/lib/xfce4/xfconf/xfconfd &
xfsettingsd &
xfce4-power-manager &

# Start i3 window manager
exec i3
#exec cinnamon-session
