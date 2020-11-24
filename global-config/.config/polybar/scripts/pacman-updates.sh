#!/bin/bash

#sudo $HOME/.config/polybar/scripts/remove-pacman-update-lock.sh > /dev/null && sudo pacman -Sy > /dev/null && pacman -Qu | wc -l | cut -f 1 -d ' ' || echo '?'

[ `cat /proc/uptime | cut -d '.' -f 1` -gt 5 ] || sleep 5
yay -Qu | wc -l
