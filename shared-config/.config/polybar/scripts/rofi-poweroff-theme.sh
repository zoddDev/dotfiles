#!/bin/bash

echo -e "Logout\nReboot\nShutdown" | rofi -font "Iosevka Bold 12" -show drun -show-icons -width 20 -lines 3 -dmenu -i -config ~/.config/rofi/configNotif.rasi
