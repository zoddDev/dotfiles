#!/bin/bash

replace_user="zodd"

SETUP_ROOT="$(dirname "$PWD")"

notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Copying themes, icons, fonts and scripts..." &
cp -rv $SETUP_ROOT/dotfiles/.scripts $HOME

sudo cat $SETUP_ROOT/dotfiles/environment >> /etc/environment

[ -d $HOME/Pictures/Wallpapers ] || mkdir -p $HOME/Pictures/Wallpapers
cp -rv $SETUP_ROOT/dotfiles/Wallpapers $HOME/Pictures/Wallpapers

cp -rv $SETUP_ROOT/dotfiles/.scripts $HOME
cp -rv $SETUP_ROOT/dotfiles/.fonts $HOME
cp -rv $SETUP_ROOT/dotfiles/.icons $HOME
cp -rv $SETUP_ROOT/dotfiles/.themes $HOME

cp -rv $SETUP_ROOT/dotfiles/global-config/. $HOME

sed -i "s/$replace_user/$USER/g" $HOME/.zshrc $HOME/.config/nitrogen/*.cfg

# change shell to zsh, will require password
chsh -s /usr/bin/zsh
