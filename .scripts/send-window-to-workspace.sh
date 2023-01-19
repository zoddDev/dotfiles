#!/bin/bash
LAST_DESKTOP=`wmctrl -d | grep "*" | cut -d ' ' -f 1`

wmctrl -r :ACTIVE: -t $1; wmctrl -s $1 && echo $LAST_DESKTOP > ~/.config/last-workspace


