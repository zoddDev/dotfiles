#!/usr/bin/zsh


NUMBER_OF_THEMES=7
source ~/.zshrc

function change_theme {
    current_theme=`cat ~/.config/current_theme`
    chosen=$1
    [[ $chosen == $current_theme ]] && notify-send -i ~/.config/polybar/scripts/resources/white-brush.png "[WARNING]: You are already using this theme!" && return 1

    cd $DOTFILES && nohup $SHELL -c "~/.config/neofetch/launch-neofetch.sh ; $DOTFILES/setup-scripts/rices.sh $chosen ; ~/.config/polybar/scripts/after-theme-swap.sh"
}


chosen=$(echo -e "nord\npink-nord\npink-nord-alternative\ngruvbox\nsolarized-dark\nhorizon\nayu" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines $NUMBER_OF_THEMES -dmenu -i)

[ -z $chosen ] || change_theme $chosen
