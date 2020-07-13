# dotfiles

Those are my different bspwm themes dotfiles

# install

You can install one of them by running the setup executable.

Installing packages:

[WARNING!]: Support for Arch Linux based systems only (installation via pacman):

Use:

```shell
./setup.sh <OPTION> 
```

where <OPTION> may be:

general      - installs necessary packages from pacman 
git          - installs necessary packages from AUR and github 
wifi         - (only for wireless connection!) installs 2 packages for wireless connection support

You can also do:

```shell
./setup.sh <OPTION> <THEME_NAME>
```
where <OPTION> may be:

theme        - installs <THEME_NAME> theme
all          - installs all packages and finally installs selected theme if 2nd argument exists


where <THEME_NAME> may be:

doombox                 - Doom version of gruvbox
alternative-gruvbox     - atypical version of gruvbox with lightly changed palette
solarized-dark          - Solarized Dark theme with a small vaporwave flavour (with some pinkier colors)

