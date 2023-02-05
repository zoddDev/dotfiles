![alt text](readme-resources/dotfiles_.png)

### Hello there! :octocat:

Those are my bspwm dotfiles, hope you find something useful here ^^

Specific rices configs and colorschemes are [here](https://github.com/zodd18/dotfiles/tree/master/rices) and general configuration files are [here](https://github.com/zodd18/dotfiles/tree/master/shared-config). You will need both.

Here are some details about my setup:
<a href="https://youtu.be/_PTp5mh5_vQ"><img src="https://static.vecteezy.com/system/resources/previews/010/948/374/original/cute-food-character-funny-sushi-traditional-japanese-food-in-cartoon-kawaii-illustration-for-emoticon-symbol-icon-etc-png.png" alt="" align="right" width="400px"></a>
- **WM**                           : [bspwm](https://github.com/baskerville/bspwm) :art: several switchable themes!
- **Shell**                        : [zsh](https://wiki.archlinux.org/index.php/zsh) :shell: with [oh my zsh](https://github.com/ohmyzsh/ohmyzsh) framework!
- **Terminal**                     : [kitty](https://github.com/kovidgoyal/kitty) :cat:
- **Panel**                        : [polybar](https://github.com/polybar/polybar) :shaved_ice: using [nerd fonts](https://github.com/ryanoasis/nerd-fonts) glyphs as icons!
- **Compositor**                   : [picom](https://github.com/chjj/compton) :sparkles:
- **Notify Daemon**                : [dunst](https://wiki.archlinux.org/index.php/Dunst) 🔔 
- **Application Launcher**         : [rofi](https://github.com/davatorium/rofi) :rocket: apps & sidebar menu!
- **File Manager**                 : [thunar](https://wiki.archlinux.org/index.php/Thunar)/[ranger](https://github.com/ranger/ranger) 📂 minimal file managers!
- **Wallpaper Manager**            : [nitrogen](https://github.com/l3ib/nitrogen) 🖼️

<br/>
<br/>
<br/>
<br/>
<pre align="center">
  <div align="center">
    <a href="#art-custom-theme-swap-utility">THEME SWAP</a> • <a href="#arrow_down-download">DOWNLOAD</a> • <a href="#gear-installation">INSTALLATION</a> • <a href="#information_source-use-cases">USE CASES</a>
  </div>
</pre>

![alt text](readme-resources/themes_.png)

## [:maple_leaf: Horizon](https://github.com/zodd18/Horizon)
![alt text](https://github.com/zodd18/Horizon/blob/master/screenshot.png) 


<br/><br/>

## [❄️ Nord](https://github.com/zoddDev/Nord) (using ![Genome 🧬](https://www.reddit.com/r/unixporn/comments/kzd6zt/qtile_genome/) decorations)
![alt text](https://github.com/zoddDev/Nord/blob/master/screenshot.png) 


<br/><br/>

## [🌲 Forest](https://github.com/zodd18/Forest)
![alt text](https://github.com/zodd18/Forest/blob/master/screenshot.png) 


<br/><br/>

## [🔥 DOOMBOX](https://github.com/zodd18/Doombox)
![alt text](https://github.com/zodd18/Doombox/blob/master/screenshot.png) 

<br/><br/>

## [🍃 GruvboxMaterial](https://github.com/zoddDev/GruvboxMaterial)
![alt text](https://github.com/zoddDev/GruvboxMaterial/blob/main/screenshot.png) 


<br/><br/>

## [🌸 PinkNord](https://github.com/zodd18/PinkNord)
![alt text](https://github.com/zodd18/PinkNord/blob/master/screenshot.png) 


<br/><br/>

## [🌊 SolarizedDark](https://github.com/zodd18/SolarizedDark)
![alt text](https://github.com/zodd18/SolarizedDark/blob/master/screenshot.png) 


<br/><br/>

## [🎀 PinkNordAlternative](https://github.com/zodd18/PinkNordAlternative) (using [Fleon](https://github.com/owl4ce/dotfiles) colorscheme)
![alt text](https://github.com/zodd18/PinkNordAlternative/blob/master/screenshot.png) 

<br/><br/>

## [🌴 Gruvbox](https://github.com/zodd18/Gruvbox)
![alt text](https://github.com/zodd18/Gruvbox/blob/master/screenshot.png) 

<br/>

<hr>

# :art: Custom Theme Swap Utility

### Click the brush icon in the polybar
<img src="./screenshots/brush.png" width=160 height=100>

## Select a rice
![alt text](screenshots/theme-swap-showcase.png)

## Now you have a completely new look and feel for your Linux desktop!
![alt text](screenshots/theme-swap-showcase-2.png)


![alt text](readme-resources/scripts_.png)

#### ⚠️ WARNING - These are my personal config files, executing these scripts will overwrite several configuration files in your system. Only execute these in case you have a backup of your current configuration.

## :arrow_down: Download

ℹ️ For now, it's **mandatory** to clone this repo in `~/Documents/git-lab` to use the [Theme Swap Utility](#art-custom-theme-swap-utility), otherwise you won't be able to switch between these themes on the fly.

```
mkdir -p ~/Documents/git-lab && git clone --depth=1 https://github.com/zoddDev/dotfiles.git ~/Documents/git-lab/dotfiles && cd ~/Documents/git-lab/dotfiles
```

<hr>

## :gear: Installation
You can install the needed packages and configuration files by running the setup executable.

### 📦 Installing needed packages and general configurations:

#### ℹ️ Package installation is ONLY supported for **Arch Linux** based systems (installation via pacman).

Execute:

```shell
./setup.sh <ARG> 
```

where 
```<ARG>```
may be:

```
packages        - installs needed packages using yay (also installs yay if needed)
themes          - installs shared configuration between all rices: .themes, .icons, .fonts, wallpapers and necessary scripts
```


### 🖼️ Installing a specific rice:

Execute:


```shell
./setup.sh <ARG> <RICE_NAME>
```

where 
```<ARG>```
may be:

```
rice         - downloads (if needed) and installs <RICE_NAME> rice
all          - installs all at once: packages, GTK themes, etc. And finally installs <RICE_NAME> theme if this argument was passed
```

where 
```<RICE_NAME>```
may be:

```
nord                    - Nord theme
dracula                 - Dracula theme
gruvbox                 - Gruvbox theme
gruvbox-material        - Soft edition of Gruvbox theme
solarized-dark          - Solarized Dark theme
horizon                 - Based on VS Code Horizon theme
forest                  - Everforest theme
pink-nord               - Pink Nord theme
pink-nord-alternative   - Based on Fleon theme
doombox                 - Doom version of gruvbox theme
```

### :information_source: Use cases:

```
setup.sh all horizon
```
(This command would install all needed packages, themes, icons and would also install [**Horizon**](https://github.com/zoddDev/Horizon) rice)

<hr>

```
setup.sh packages
```
(This command would download and install all the needed packages using yay)

<hr>

```
setup.sh themes
```
(This command would install shared configurations between all rices, mandatory)

<hr>

```
setup.sh rice horizon
```
(This command would install [**Horizon**](https://github.com/zoddDev/Horizon) rice)
