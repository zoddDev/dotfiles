#!/bin/bash

arg=$1

if [ "$arg" = "aur" ];
then 
    pacman_arg='Qm'
    output_file='aur-packages'
elif [ "$arg" = "pacman" ];
then
    pacman_arg='Qn'
    output_file='pacman-packages'
else
    echo "No option named: \"$arg\""
    echo "No packages list to update, exiting..."
    exit
fi

sudo pacman -$pacman_arg | cut -d ' ' -f 1 > $DOTFILES/setup-scripts/resources/$output_file
