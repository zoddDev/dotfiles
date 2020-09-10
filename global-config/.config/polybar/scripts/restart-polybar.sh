#!/bin/bash

cp $HOME/.config/polybar/config.bspwm $HOME/.config/polybar/config
killall polybar

polybar example &

sleep 1
xdo lower -N Polybar
