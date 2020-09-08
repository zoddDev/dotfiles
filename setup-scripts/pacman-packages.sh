#! /bin/bash

echo "[START]: general-packages installation..."

sudo pacman -Sy `cat ./resources/general-packages`

# ranger icons:
devicons_dir=$HOME/.config/ranger/plugins/ranger_devicons
[ -d $devicons_dir ] && rm -rf $devicons_dir
git clone https://github.com/alexanderjeurissen/ranger_devicons $devicons_dir

echo "[FINISHED]: general-packages installation"
