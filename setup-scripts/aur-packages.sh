#! /bin/bash

echo "[START]: aur/external-packages installation..."

# import keys
./.scripts/addkey.sh `cat ./setup-scripts/resources/keys | grep -v '#'`

# output packages directory creation
[ -d $HOME/Downloads/git-downloads ] || mkdir -p $HOME/Downloads/git-downloads

#
# AUR
#

# yay
# https://aur.archlinux.org/yay.git
sudo pacman -Qi yay || ./.scripts/aur-get https://aur.archlinux.org/yay.git

yes | yay -Syu
yes | yay -S --needed --mflags --skipinteg --overwrite "*" --nodeps --nodeps `cat ./setup-scripts/resources/aur-packages` || exit 1
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

yay -S --noconfirm --needed --mflags --skipinteg --overwrite "*" wmutils-git ueberzug

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
# use: python -m beautifuldiscord --css ~/.config/discord/rices/$THEME_NAME

echo "[FINISHED]: aur/external-packages installation"
