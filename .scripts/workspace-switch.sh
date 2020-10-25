#!/bin/bash
LAST_DESKTOP=`wmctrl -d | grep "*" | cut -d ' ' -f 1`

[ ! $LAST_DESKTOP -eq $1 ] && wmctrl -s $1 && echo $LAST_DESKTOP > ~/.config/last-workspace
