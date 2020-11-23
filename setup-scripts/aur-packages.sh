#! /bin/bash

echo "[START]: aur/external-packages installation..."

# output packages directory creation
[ -d $HOME/Downloads/git-downloads ] || mkdir -p $HOME/Downloads/git-downloads

#
# AUR
#

# yay
# https://aur.archlinux.org/yay.git
sudo pacman -Qi yay || ./setup-scripts/aur-get https://aur.archlinux.org/yay.git

yay -S --mflags --skipinteg `cat ./setup-scripts/resources/aur-packages`
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

pip install dbus-python

# spicetify-cli
# https://aur.archlinux.org/spicetify-cli.git
# spicetify config current_theme $THEME_NAME
# spicetify auto backup apply

#
# GITHUB
#

# BeautifulDiscord
# https://github.com/leovoel/BeautifulDiscord
#python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
# use: python -m beautifuldiscord --css ~/.config/discord/themes/$THEME_NAME

echo "[FINISHED]: aur/external-packages installation"
