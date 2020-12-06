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
yay -Syu

yes "y" | yay -S --noconfirm --useask --norebuild --needed --batchinstall --mflags --skipinteg --overwrite "*" --nodeps `cat ./setup-scripts/resources/aur-packages` || exit 1
yes "y" | yay -S --noconfirm --useask --norebuild --needed --batchinstall --mflags --skipinteg --overwrite "*" --nodeps wmutils-git ueberzug

pip install dbus-python

# spicetify-cli
# https://aur.archlinux.org/spicetify-cli.git
# spicetify config current_theme $THEME_NAME
# spicetify auto backup apply
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

#
# GITHUB
#

# BeautifulDiscord
# https://github.com/leovoel/BeautifulDiscord
#python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
# use: python -m beautifuldiscord --css ~/.config/discord/rices/$THEME_NAME

echo "[FINISHED]: aur/external-packages installation"
