#!/bin/bash

replace_user="zodd"

SETUP_ROOT="$(dirname "$PWD")"

notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: Copying themes, icons, fonts and scripts..." &
cp -rv $SETUP_ROOT/dotfiles/.scripts $HOME

sudo cat $SETUP_ROOT/dotfiles/environment >> /etc/environment
[ -d $HOME/Pictures/Screenshots ] || mkdir -p $HOME/Pictures/Screenshots

echo "[INFO]: Copying wallpapers..."
[ -d $HOME/Pictures/Wallpapers ] || mkdir -p $HOME/Pictures/Wallpapers
cp -r $SETUP_ROOT/dotfiles/Wallpapers $HOME/Pictures/Wallpapers
echo "[INFO]: Copying scripts..."
cp -r $SETUP_ROOT/dotfiles/.scripts $HOME
echo "[INFO]: Copying fonts..."
cp -r $SETUP_ROOT/dotfiles/.fonts $HOME
echo "[INFO]: Copying themes..."
cp -r $SETUP_ROOT/dotfiles/.themes $HOME
echo "[INFO]: Copying icons..."
cp -r $SETUP_ROOT/dotfiles/.icons $HOME

cp -rv $SETUP_ROOT/dotfiles/global-config/. $HOME

# install plugins for nvim
nvim -E -s -u "$HOME/.config/nvim/init.vim" +PlugInstall +qall

sed -i "s/$replace_user/$USER/g" $HOME/.zshrc $HOME/.config/sxhkd/sxhkdrc*

# change shell to zsh, will require password and reboot to apply changes
chsh -s /usr/bin/zsh

$SETUP_ROOT/dotfiles/setup-scripts/kb-layout.sh
