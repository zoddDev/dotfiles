#! /bin/bash

echo "[START]: general-packages installation..."

sudo pacman -Sy --needed --noconfirm --overwrite "*" `cat ./setup-scripts/resources/pacman-packages` || exit 1

# ranger icons:
devicons_dir=$HOME/.config/ranger/plugins/ranger_devicons
[ -d $devicons_dir ] && rm -rf $devicons_dir
git clone https://github.com/alexanderjeurissen/ranger_devicons $devicons_dir

echo "[FINISHED]: general-packages installation"
