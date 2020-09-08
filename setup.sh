#!/bin/bash

option=$1
theme=$2

shopt -s nocasematch
case "$option" in
    "all" ) ./setup-scripts/general-packages.sh && ./setup-scripts/aur-packages.sh && ./setup-scripts/themes.sh && ./setup-scripts/rices.sh $theme ;; # $theme is theme name
    "general" ) ./setup-scripts/general-packages.sh ;; 
    "aur" ) ./setup-scripts/aur-packages.sh ;; 
    "rice" ) ./setup-scripts/rices.sh $theme ;; # $theme is theme name
    "themes" ) ./setup-scripts/themes.sh ;; # Installs themes, icons, fonts, wallpapers and scripts

    *) echo "[ERROR]: no config with name \"$option\" found" && exit 1 ;;
esac

