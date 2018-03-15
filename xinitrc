#!/usr/bin/env bash

xrdb .Xresources
setxkbmap -option ctrl:nocaps
xrandr --output HDMI-1 --left-of DVI-D-1
xrandr --output HDMI-1 --primary
xset m 1/1 9999
hsetroot -solid '#073642'

command -v xsetwacom &> /dev/null && {
    output="HDMI-1"

    echo "$(xsetwacom --list)" | while read -r line
    do
        device=$(echo $line | sed 's/ id:.*//')
        xsetwacom set "$device" MapToOutput $output
    done
}

exec i3
