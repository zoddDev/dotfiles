#!/bin/bash

replace_user="zodd"

echo "[INFO]: Copying themes, icons, fonts and scripts..."
notify-send -i ./setup-scripts/resources/white-brush.png "[INFO]: Copying themes, icons, fonts and scripts..." &

sudo cat ./environment >> /etc/environment

# screenshots folder to store scrot screenshots
[ -d $HOME/Pictures/Screenshots ] || mkdir -p $HOME/Pictures/Screenshots

echo "[INFO]: Copying wallpapers..."
cp -r ./.wallpapers $HOME
echo "[INFO]: Copying scripts..."
cp -r ./.scripts $HOME
echo "[INFO]: Copying fonts..."
cp -r ./.fonts $HOME
echo "[INFO]: Copying themes..."
cp -r ./.themes $HOME
echo "[INFO]: Copying icons..."
cp -r ./.icons $HOME

# copy global/shared config to $HOME
cp -rv ./shared-config/. $HOME

# install plugins for nvim
nvim -E -s -u "$HOME/.config/nvim/init.vim" +PlugInstall +qall

sed -i "s/$replace_user/$USER/g" $HOME/.zshrc $HOME/.config/sxhkd/sxhkdrc*

# default wm is bspwm
cp $HOME/.config/sxhkd/sxhkdrc.bspwm $HOME/.config/sxhkd/sxhkdrc

# change user default shell to zsh, will require password and reboot to apply changes
chsh -s /usr/bin/zsh

# ask user for keyboard layout
./setup-scripts/kb-layout.sh
