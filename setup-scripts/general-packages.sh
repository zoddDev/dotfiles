#! /bin/bash

echo "[START]: general-packages installation..."

sudo pacman -Sy xset firefox chromium fish alacritty bspwm openbox sxhkd dunst feh nitrogen rofi lxappearance git python3 discord spotify nomacs mpv ranger thunar neovim jdk8-openjdk openjdk8-doc openjdk8-src java8-openjfx java8-openjfx-doc java8-openjfx-src neofetch ranger pulsemixer zathura zathura-djvu zathura-pdf-poppler zathura-ps chromium neomutt htop kcolorchooser lxsession nodejs yarn npm ttf-fira-code cantarell-fonts consolas-fonts gnome-disk-utility ttf-inconsolata spectacle qt5ct file-roller

# ranger icons:
devicons_dir=$HOME/.config/ranger/plugins/ranger_devicons
[ -d $devicons_dir ] && rm -rf $devicons_dir
git clone https://github.com/alexanderjeurissen/ranger_devicons $devicons_dir

echo "[FINISHED]: general-packages installation"
