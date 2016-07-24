#!/usr/bin/env bash

xrdb .Xresources
setxkbmap -option ctrl:nocaps
xrandr --output HDMI-1 --left-of DVI-D-1
xrandr --output HDMI-1 --primary
xset m 1/1 9999
hsetroot -solid '#073642'

exec i3
