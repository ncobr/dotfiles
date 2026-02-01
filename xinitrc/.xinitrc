#!/bin/bash

# Set keyboard layout

setxkbmap -layout latam &
#wal -R &

#nitrogen --restore &
#xsetroot -cursor_name left_ptr &
# fastcompmgr -o 0.9 -r 12 -c -C -i 0.9 &

#/usr/bin/dunst &
#nm-applet &

#blueman-applet &
#udiskie -t -A &
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_TYPE=x11
/usr/lib/xdg-desktop-portal -r &
/usr/lib/xdg-desktop-portal-gtk -r &

# Start XFCE services in the background
# /usr/lib/xfce4/xfconf/xfconfd &
# xfsettingsd &
# xfce4-power-manager &

# Start window manager
#exec ~/bin/startdwm
exec i3
