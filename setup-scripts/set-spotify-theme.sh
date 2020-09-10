#!/bin/bash

spicetify_theme=$1

shopt -s nocasematch
case "$current_theme" in 
    "gruvbox" ) setup_config "Gruvbox" "Gruvbox-Gold" ;; 
    "solarized-dark" ) setup_config "SolarizedDark" "SolarizedDark" ;; 
    "pink-nord" ) setup_config "PinkNord" "Nord" ;; 
    #"nord" ) setup_config "Nord" "Nord" ;; 
    *) echo "[ERROR]: no config with name \"$current_theme\" found" && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[ERROR]: Selected theme does not exist" && exit 1 ;;
esac

#
# configuring spotify theme (spicetify)
#
echo 
echo "[INFO]: applying \"$spicetify_theme\" spicetify theme..."

$HOME/spicetify-cli/spicetify config current_theme $spicetify_theme
$HOME/spicetify-cli/spicetify apply

sleep 1
killall spotify

bspc desktop -f '^1' --follow
