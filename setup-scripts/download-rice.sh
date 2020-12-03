#!/bin/bash

theme_name=$1
notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Downloading... \"$theme_name\" rice..." &
[ ! -z $theme_name ] && cd ./themes/$theme_name && git submodule update --init . && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Download for \"$theme_name\" finished successfully!" &

