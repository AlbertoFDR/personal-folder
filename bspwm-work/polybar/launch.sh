#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch bar
polybar top &

# Configure external monitors
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		if [ "$m" == "HDMI-2" ]; then
			MONITOR=$m polybar --reload right_external &
		fi
		if [ "$m" == "DP-1" ]; then
	    		MONITOR=$m  polybar --reload left_external &
		fi
  done
fi

