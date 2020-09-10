#!/bin/bash

killall polybar

polybar example &

sleep 1
xdo lower -N Polybar
