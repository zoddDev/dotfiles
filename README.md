![alt text](readme-resources/dotfiles.png)


Hello there!

Those are my different bspwm and (no longer supported) openbox themes dotfiles, hope you find something useful in this mess ^^

I hope you understand everything here. :wink:

Here are some details about my setup:
- **WM**                           : [bspwm](https://github.com/baskerville/bspwm) :art: 4 changable themes/mode!
- **DM**                           : [getty](https://wiki.archlinux.org/index.php/Getty) :blossom: minimal DM!
- **Shell**                        : [zsh](https://wiki.archlinux.org/index.php/zsh) :shell: with [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) framework!
- **Terminal**                     : [kitty](https://github.com/kovidgoyal/kitty) :cat:
- **Panel**                        : [polybar](https://github.com/polybar/polybar) :shaved_ice: [nerd fonts](https://github.com/ryanoasis/nerd-fonts)  glyphs!
- **Compositor**                   : [compton](https://github.com/chjj/compton) :sparkles:
- **Notify Daemon**                : [Dunst](https://wiki.archlinux.org/index.php/Dunst) :leaves: minimalism!
- **Application Launcher**         : [Rofi](https://github.com/davatorium/rofi) :rocket: apps & sidebar menu!
- **File Manager**                 : [Thunar](https://wiki.archlinux.org/index.php/Thunar) :bookmark: customized sidebar & icon!
- **Text Editor**                  : [nvim](https://github.com/neovim/neovim) :computer:


![alt text](readme-resources/themes.png)

## PinkNord Alternative [(Fleon based)](https://github.com/owl4ce/dotfiles)
![alt text](screenshots/Alternative-pinknord.png)

## PinkNord
![alt text](screenshots/PinkNord.png)

<br/><br/>

## Gruvbox
![alt text](screenshots/Gruvbox.png)

<br/><br/>

## SolarizedDark
![alt text](screenshots/SolarizedDark.png)

# Custom Theme Swap Utility

## Click the brush icon
![alt text](./screenshots/brush_.jpg)

## Choose the rice that you desire
![alt text](screenshots/theme-swap-showcase.png)

## Nice! Now you have a completely look and feel for your Linux desktop!
![alt text](screenshots/theme-swap-showcase-2.png)


![alt text](readme-resources/scripts.png)

## [WARNING]: Installation scripts are still work in progress. Use them at your own risk!!
### [WARNING!]: These are my personal config files, executing these scripts will overwrite several files in your system, only execute these in case you have a backup of your files.

## Download
```
mkdir -p ~/Documents/git-lab && git clone https://github.com/zodd18/dotfiles.git ~/Documents/git-lab
```

## Executing the script
You can install one of them by running the setup executable.

Installing necessary packages:

[WARNING!]: Support for Arch Linux based systems only (installation via pacman).

Use:

```shell
./setup.sh <ARG> 
```

where 
```<ARG>```
may be:

```
pacman       - installs necessary packages from pacman
aur          - installs necessary packages from AUR and external sources
themes       - installs .themes, .icons, .fonts, wallpapers and necessary/personal scripts
```

You can also do:


```shell
./setup.sh <ARG> <THEME_NAME>
```

where 
```<ARG>```
may be:

```
rice         - installs <RICE_NAME> rice
all          - installs all at once: pacman packages, aur packages, GTK themes, etc. And finally installs <RICE_NAME> theme if this argument was passed
```

where 
```<RICE_NAME>```
may be:

```
pink-nord               - Pink Nord look
gruvbox                 - Classic Gruvbox look
solarized-dark          - Solarized Dark look
pink-nord-alternative   - Based on Fleon look
```

example:

```
setup.sh all pink-nord
```
(this command would install all necessary packages, themes, icons and would install pink-nord rice)

### Recomendation
You can try to install all at once by using "all" argument, however I'd install it one by one in case any installation fails. 
I'd follow this order: pacman, aur, themes, rice.

# Deprecated (old rices, they need a lot of cleaning)
```
nord                    - Classic Nord look
dracula                 - Classic Dracula look
doombox                 - Doom version of gruvbox
```

