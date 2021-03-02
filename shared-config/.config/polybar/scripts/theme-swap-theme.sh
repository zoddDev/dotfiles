#!/bin/bash

NUMBER_OF_THEMES=9
AVAILABLE_THEMES=$(cat $HOME/.config/polybar/scripts/available-themes)
echo -e $AVAILABLE_THEMES | rofi -font "Iosevka Bold 11" -show drun -show-icons -width 20 -lines $NUMBER_OF_THEMES -dmenu -i -config "~/.config/rofi/config.rasi"

