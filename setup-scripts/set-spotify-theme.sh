#!/bin/bash

function set_theme {
    spicetify_theme=$1
    
    #
    # configuring spotify theme (spicetify)
    #
    echo "[INFO]: applying \"$spicetify_theme\" spicetify theme..."
    $HOME/spicetify-cli/spicetify config current_theme $spicetify_theme
    $HOME/spicetify-cli/spicetify apply
}

[ -z $1 ] || set_theme $1
current_theme=`cat $HOME/.config/current_theme`

shopt -s nocasematch
case "$current_theme" in 
    "gruvbox" ) set_theme "Gruvbox-Gold" ;; 
    "solarized-dark" ) set_theme "SolarizedDark" ;; 
    "pink-nord" ) set_theme "Nord" ;; 
    #"nord" ) set_theme "Nord" ;; 
    *) echo "[ERROR]: no config with name \"$current_theme\" found" && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[ERROR]: Selected theme does not exist" && exit 1 ;;
esac

