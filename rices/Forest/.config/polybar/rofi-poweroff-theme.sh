#!/bin/bash

echo -e "Logout\nReboot\nShutdown" | rofi -font "Iosevka Nerd Font Mono 9" -show drun -show-icons -width 20 -lines 3 -dmenu -i -config "~/.config/rofi/config.rasi"
