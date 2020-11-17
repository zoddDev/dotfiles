#!/bin/bash

bspc rule -a \* -o state=floating && kitty -e /bin/zsh -c "~/.config/neofetch/launch-neofetch.sh && cat" &
disown
