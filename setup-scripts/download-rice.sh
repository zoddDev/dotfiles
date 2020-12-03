#!/bin/bash

theme_name=$1
notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Downloading... \"$theme_name\" rice..." &
success=0
[ ! -z $theme_name ] && cd ./themes/$theme_name && git submodule update --init . && success=1

[ success -eq 1 ] && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Download for \"$theme_name\" finished successfully!" &
[ success -eq 1 ] && exit 0

