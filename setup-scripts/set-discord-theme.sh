#!/bin/bash

beautifuldiscord_theme="custom-discord-theme.css"

#
# configuring discord theme (beautifuldiscord)
#
echo 
echo "[INFO]: applying \"$config_name\" beautiful-discord theme..."
notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: applying \"$config_name\" beautiful-discord theme..."
                                                                                                                                                    
if [ `ps -e | grep discord | wc -l` > 0 ];
then
    discord > /dev/null & 
    sleep 1
fi
                                                                                                                                                    
python -m beautifuldiscord --revert
sleep 3
python -m beautifuldiscord --css $HOME/.config/discord/rices/$beautifuldiscord_theme
sleep 3
killall discord

bspc desktop -f '^1' --follow
