#!/bin/bash

theme_name=$1
notify-send -i ./setup-scripts/resources/white-brush.png "[INFO]: Downloading... \"$theme_name\" rice..." &
success=0

[ ! -z $theme_name ] && git submodule update --init --depth 1 --recursive ./rices/$theme_name && cd ./rices/$theme_name
notify-send -i ./setup-scripts/resources/white-brush.png "[INFO]: Download for \"$theme_name\" finished" &
