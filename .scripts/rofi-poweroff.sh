#!/bin/bash

chosen=$(echo -e "Logout\nReboot\nShutdown" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines 3 -dmenu -i)

if [[ $chosen = "Logout" ]]; then
    bspc quit
elif [[ $chosen = "Shutdown" ]]; then
	systemctl poweroff
elif [[ $chosen = "Reboot" ]]; then
	systemctl reboot
fi
