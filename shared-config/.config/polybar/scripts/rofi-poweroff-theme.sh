#!/bin/bash

echo -e "Logout\nReboot\nShutdown" | rofi -font "Iosevka Bold 11" -show drun -show-icons -width 20 -lines 3 -dmenu -i -config "~/.config/rofi/config.rasi"
