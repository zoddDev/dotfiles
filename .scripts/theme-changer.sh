#!/bin/bash

function change_theme {
    current_theme = `cat $HOME/.config/current_theme`
}


chosen=$(echo -e "PinkNord\nGruvbox" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines 3 -dmenu -i)

change_theme $chosen
