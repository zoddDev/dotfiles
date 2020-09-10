#!/bin/bash

bspc rule -a \* -o state=floating 
bspc desktop -f '^1' --follow 
kitty -e $SHELL -c "cd && $HOME/.config/neofetch/launch-neofetch.sh && $SHELL"

