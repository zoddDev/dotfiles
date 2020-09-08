#!/bin/bash

sudo $HOME/.config/polybar/scripts/remove-pacman-update-lock.sh > /dev/null
sudo pacman -Sy > /dev/null 
pacman -Qu &> /dev/null | wc -l | cut -f 1 -d ' '
