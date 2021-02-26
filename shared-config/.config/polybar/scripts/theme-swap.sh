#!/usr/bin/zsh

source ~/.zshrc
function change_theme {
    current_theme=`cat ~/.config/current_theme`
    chosen=$1
    [[ $chosen == $current_theme ]] && notify-send -i ~/.config/polybar/scripts/resources/white-brush.png "[WARNING]: You are already using this theme!" && return 1

    nohup $SHELL -c "cd $DOTFILES && $DOTFILES/setup-scripts/rices.sh $chosen ; ~/.config/polybar/scripts/after-theme-swap.sh"
}

chosen=$($HOME/.config/polybar/scripts/theme-swap-theme.sh)

[ -z $chosen ] || change_theme $chosen
