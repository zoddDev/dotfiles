#!/bin/bash

function change_theme {
    current_theme=`cat $HOME/.config/current_theme`
    chosen=$1

    [[ $chosen == $current_theme ]] && notify-send -i $HOME/.config/polybar/scripts/resources/white-brush.png "[WARNING]: You are already using this theme!" && return 1

    DOTFILES=/home/zodd/Documents/git-lab/dotfiles
    cd $DOTFILES 
    bspc rule -a \* -o state=floating
    kitty -e /bin/bash -c "$DOTFILES/setup.sh theme $chosen"
}


chosen=$(echo -e "pink-nord\ngruvbox" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines 2 -dmenu -i)

change_theme $chosen
