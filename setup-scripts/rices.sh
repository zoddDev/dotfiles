#! /bin/bash

echo "[START]: theme installation..."

SETUP_ROOT="$(dirname "$PWD")"
arg=$1
copy_icons_and_themes=$2

function setup_config {
    # args
    config_name=$1
    spicetify_theme=$2
    beautifuldiscord_theme=$3
    
    # backup of .xinitrc and .bashrc
    cp $HOME/.xinitrc $HOME/.xinitrc-backup
    cp $HOME/.bashrc $HOME/.bashrc-backup

    notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: copying \"$config_name\" config files..."

    #
    # copying theme dotfiles
    #
    echo
    echo "[INFO]: applying \"$config_name\" theme..."

    sudo cp -r -a $SETUP_ROOT/dotfiles/themes/$config_name/. $HOME
    dconf load /org/gnome/gedit/ < $HOME/.config/gedit-dump.dconf
    cp -r $SETUP_ROOT/dotfiles/global-config/. $HOME
    [ -f $HOME/.config/fish/additional_config.fish ] && cat $HOME/.config/fish/additional_config.fish >> $HOME/.config/fish/config.fish
    [ -f $HOME/.config/current_theme ] && echo "include `cat ~/.config/current_theme `.conf" >> $HOME/.config/kitty/kitty.conf

    #
    # configuring discord theme (beautifuldiscord)
    #
    nohup $SETUP_ROOT/dotfiles/setup-scripts/set-discord-theme.sh $beautifuldiscord_theme &

    #
    # configuring spotify theme (spicetify)
    #
    nohup $SETUP_ROOT/dotfiles/setup-scripts/set-spotify-theme.sh $spicetify_theme &

    echo "[FINISHED]: theme installation"
    notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: FINISHED! Enjoy your new theme :)"
}

shopt -s nocasematch
case "$arg" in 
    "doombox" ) setup_config "DOOMBOX" "Gruvbox-Gold" "Duvbox/duvbox.css" ;; 
    "gruvbox" ) setup_config "Gruvbox" "Gruvbox-Gold" "Duvbox/duvbox.css" ;; 
    "alternative-gruvbox" ) setup_config "AlternativeGruvbox" "Gruvbox-Gold" "Duvbox/duvbox.css" ;; 
    "solarized-dark" ) setup_config "SolarizedDark" "SolarizedDark" "SolarizedDark/solarized_dark.css" ;; 
    "dracula" ) setup_config "Dracula" "Dracula" "Dracula/discord-dracula.css" ;; 
    "nord" ) setup_config "Nord" "Nord" "Nord/discord-nord.css" ;; 
    "pink-nord" ) setup_config "PinkNord" "Nord" "Nord/discord-nord.css" ;; 

    *) echo "[ERROR]: no config with name \"$arg\" found" && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[ERROR]: Selected theme does not exist" && exit 1 ;;
esac



