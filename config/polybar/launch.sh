#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# External monitor bar
POLYBAR_MONITOR=DP-1 polybar top &
POLYBAR_MONITOR=HDMI-2 polybar top &

# MacBook Pro bar
POLYBAR_MONITOR=eDP-1 POLYBAR_DPI=120 polybar top &
