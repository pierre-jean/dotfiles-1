#!/bin/sh
xrandr --output DP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI2 --mode 1600x1200 --pos 1920x0 --rotate left --output DP2 --off
./i3-restart.sh
variety --next

