#!/bin/bash

killall -9 polybar
polybar example &

sleep 1
xdo lower -N Polybar
