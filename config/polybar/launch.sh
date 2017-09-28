#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 3; done

# External monitor bar
POLYBAR_MONITOR=DP1 polybar top &
POLYBAR_MONITOR=DP2 polybar top &
POLYBAR_MONITOR=HDMI2 polybar top &

# MacBook Pro bar
POLYBAR_MONITOR=eDP1 POLYBAR_DPI=120 POLYBAR_HEIGHT=60 polybar top &
