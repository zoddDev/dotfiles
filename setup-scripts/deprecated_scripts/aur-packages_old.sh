#! /bin/bash

echo "[START]: git-packages installation..."

# output packages directory creation
[ ! -d $HOME/Downloads/git-downloads ] && mkdir -p $HOME/Downloads/git-downloads

#
# AUR
#

# yay
# https://aur.archlinux.org/yay.git
./aur-get https://aur.archlinux.org/yay.git

# spicetify-cli
# https://aur.archlinux.org/spicetify-cli.git
yay -S spicetify-cli compton-tryone-git pfetch-git dropbox polybar python-pip ttf-monoid nerd-fonts-inconsolata ttf-monoid python-ueberzug-git qt5-styleplugins
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R

pip install dbus-python
# use:
# spicetify config current_theme $THEME_NAME
# spicetify auto backup apply

# compton-tyrone-git
# https://aur.archlinux.org/compton-tryone-git.git

# pfetch-git
# https://aur.archlinux.org/pfetch-git.git

# dropbox
# https://aur.archlinux.org/dropbox.git

#
# GITHUB
#

# BeautifulDiscord
# https://github.com/leovoel/BeautifulDiscord
python3 -m pip install -U https://github.com/leovoel/BeautifulDiscord/archive/master.zip
# use: python -m beautifuldiscord --css ~/.config/discord/themes/$THEME_NAME

echo "[FINISHED]: git-packages installation"
