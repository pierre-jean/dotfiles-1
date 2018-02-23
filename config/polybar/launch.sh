#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 3; done

export POLYBAR_FONT_0="xos4 Terminus"
export POLYBAR_FONT_1="FontAwesome"
export POLYBAR_FONT_2="DroidSansMono Nerd Font Mono"

# External monitor bar
POLYBAR_MONITOR=DP1 \
  POLYBAR_FONT_0="${POLYBAR_FONT_0}:pixelsize=14;2" \
  POLYBAR_FONT_1="${POLYBAR_FONT_1}:pixelsize=16;2" \
  POLYBAR_FONT_2="${POLYBAR_FONT_2}:pixelsize=16;2" \
  polybar top &

POLYBAR_MONITOR=DP2 \
  POLYBAR_FONT_0="${POLYBAR_FONT_0}:pixelsize=14;2" \
  POLYBAR_FONT_1="${POLYBAR_FONT_1}:pixelsize=16;2" \
  POLYBAR_FONT_2="${POLYBAR_FONT_2}:pixelsize=16;2" \
  polybar top &

POLYBAR_MONITOR=HDMI2 \
  POLYBAR_FONT_0="${POLYBAR_FONT_0}:pixelsize=14;2" \
  POLYBAR_FONT_1="${POLYBAR_FONT_1}:pixelsize=16;2" \
  POLYBAR_FONT_2="${POLYBAR_FONT_2}:pixelsize=16;2" \
  polybar top &

# MacBook Pro bar
POLYBAR_MONITOR=eDP1 \
  POLYBAR_DPI=120 \
  POLYBAR_HEIGHT=60 \
  POLYBAR_FONT_0="${POLYBAR_FONT_0}:pixelsize=24;2" \
  POLYBAR_FONT_1="${POLYBAR_FONT_1}:pixelsize=16;2" \
  POLYBAR_FONT_2="${POLYBAR_FONT_2}:pixelsize=20;2" \
  polybar top &
