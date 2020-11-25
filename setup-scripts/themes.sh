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

# install plugins for nvim
nvim -E -s -u "$HOME/.config/nvim/init.vim" +PlugInstall +qall

sed -i "s/$replace_user/$USER/g" $HOME/.zshrc 

# change shell to zsh, will require password and reboot to apply changes
chsh -s /usr/bin/zsh
