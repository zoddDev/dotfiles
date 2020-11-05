#!/bin/bash

SETUP_ROOT="$(dirname "$PWD")"

notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Copying themes, icons, fonts and scripts..." &
cp -r $SETUP_ROOT/dotfiles/.scripts $HOME

sudo cat $SETUP_ROOT/dotfiles/environment >> /etc/environment

[ -d $HOME/Pictures/Wallpapers ] || mkdir -p $HOME/Pictures/Wallpapers
cp -r $SETUP_ROOT/dotfiles/Wallpapers $HOME/Pictures/Wallpapers
cp -r $SETUP_ROOT/dotfiles/.scripts $HOME
cp -r $SETUP_ROOT/dotfiles/.fonts $HOME
cp -r $SETUP_ROOT/dotfiles/.icons $HOME
cp -r $SETUP_ROOT/dotfiles/.themes $HOME

cp -r $SETUP_ROOT/dotfiles/global-config/* $HOME

