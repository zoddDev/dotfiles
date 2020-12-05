#!/usr/bin/zsh


NUMBER_OF_THEMES=8
source ~/.zshrc

function change_theme {
    current_theme=`cat ~/.config/current_theme`
    chosen=$1
    [[ $chosen == $current_theme ]] && notify-send -i ~/.config/polybar/scripts/resources/white-brush.png "[WARNING]: You are already using this theme!" && return 1

    nohup $SHELL -c "cd $DOTFILES && $DOTFILES/setup-scripts/rices.sh $chosen ; ~/.config/polybar/scripts/after-theme-swap.sh"
}


chosen=$(echo -e "nord\npink-nord\npink-nord-alternative\ngruvbox\nsolarized-dark\nhorizon\nayu\ndoombox" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines $NUMBER_OF_THEMES -dmenu -i -config ~/.config/rofi/config)

[ -z $chosen ] || change_theme $chosen
