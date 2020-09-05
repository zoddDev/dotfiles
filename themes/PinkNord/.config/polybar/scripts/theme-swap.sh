#!/bin/bash

function change_theme {
    current_theme=`cat $HOME/.config/current_theme`
    chosen=$1

    [ $chosen = $current_theme ] && notify-send -i $HOME/.config/polybar/scripts/resources/white-brush.png "[WARNING]: You are already using this theme!"


}


chosen=$(echo -e "PinkNord\nGruvbox" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines 2 -dmenu -i)

change_theme $chosen
