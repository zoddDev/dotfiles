#!/bin/bash

chosen=$($HOME/.config/polybar/scripts/rofi-poweroff-theme.sh)

if [[ $chosen = "Logout" ]]; then
    notify-send "Logout"
    #bspc quit
elif [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "Reboot" ]]; then
	systemctl reboot
fi
