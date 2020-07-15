#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u  -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar example &
# polybar bottom &

echo Bars launched...

