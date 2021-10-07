#!/bin/bash

AVAILABLE_THEMES=$(cat $HOME/.config/polybar/scripts/available-themes)
NUMBER_OF_THEMES=10
echo -e $AVAILABLE_THEMES | rofi -font "Iosevka Bold 11" -show drun -show-icons -width 20 -lines 10 $NUMBER_OF_THEMES -dmenu -i -config "~/.config/rofi/config.rasi"

