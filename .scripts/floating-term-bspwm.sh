#!/bin/bash

bspc rule -a \* -o state=floating 
bspc desktop -f '^1'
kitty -e $SHELL -c "cd && $HOME/.config/neofetch/launch-neofetch.sh && $SHELL"

