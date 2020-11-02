#!/bin/bash

NUMBER_OF_THEMES=5

function change_theme {
    current_theme=`cat $HOME/.config/current_theme`
    chosen=$1
    [[ $chosen == $current_theme ]] && notify-send -i $HOME/.config/polybar/scripts/resources/white-brush.png "[WARNING]: You are already using this theme!" && return 1
    cd $DOTFILES 

    bspc rule -a \* -o state=floating
    nohup kitty -e $SHELL -c "$HOME/.config/neofetch/launch-neofetch.sh ; $DOTFILES/setup-scripts/rices.sh $chosen"

    bspc rule -a \* -o state=floating

    #nohup $HOME/.config/polybar/scripts/after-theme-swap.sh
    nohup kitty -e $SHELL -c "$HOME/.config/polybar/scripts/after-theme-swap.sh"
}


chosen=$(echo -e "pink-nord\npink-nord-alternative\ngruvbox\nsolarized-dark\nhorizon" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines $NUMBER_OF_THEMES -dmenu -i)

[ -z $chosen ] || change_theme $chosen

