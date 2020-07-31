# dotfiles

Hello there!

Those are my different bspwm themes dotfiles, hope you find something useful in this mess hehe ^^

# Theme Previews

## SolarizedDark
![alt text](screenshots/SolarizedDark.png)

<br/><br/>

## Gruvbox
![alt text](screenshots/Gruvbox.png)

<br/><br/>

## Dracula
![alt text](screenshots/Dracula.png)

<br/><br/>

## AlternativeGruvbox
![alt text](screenshots/Alternative-Gruvbox.png)

<br/><br/>

## DOOMBOX
![alt text](screenshots/Doombox.jpg)

<br/><br/>

# Install

You can install one of them by running the setup executable.

Installing necessary packages:

[WARNING!]: Support for Arch Linux based systems only (installation via pacman):

Use:

```shell
./setup.sh <ARG> 
```

where 
```<ARG>```
may be:

```
general      - installs necessary packages from pacman
git          - installs necessary packages from AUR and github
wifi         - (only for wireless connection!) installs 2 packages for wireless connection support
```

You can also do:


```shell
./setup.sh <ARG> <THEME_NAME>
```

where 
```<ARG>```
may be:

```
theme        - installs <THEME_NAME> theme
all          - installs all packages and finally installs selected theme if 2nd argument exists
```

where 
```<THEME_NAME>```
may be:

```
doombox                 - Doom version of gruvbox
alternative-gruvbox     - atypical version of gruvbox with lightly changed palette
solarized-dark          - Solarized Dark theme with a small vaporwave flavour (with some pinkier colors)
```
