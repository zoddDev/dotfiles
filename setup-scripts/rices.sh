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

    #
    # configuring spotify theme (spicetify)
    #
    #echo 
    #echo "[INFO]: applying \"$config_name\" spicetify theme..."

    #fish -C spicetify config current_theme $spicetify_theme &
    #sleep 5
    #fish -C spicetify apply &

    #
    # configuring discord theme (beautifuldiscord)
    #
    #echo 
    #echo "[INFO]: applying \"$config_name\" beautiful-discord theme..."

    #discord > /dev/null & 
    #sleep 5 
    #python -m beautifuldiscord --css $HOME/.config/discord/themes/$beautifuldiscord_theme

    echo "[INFO]: You maybe also need to manually set the beautiful-discord and spicetify theme separately if their installations didn't work properly"
    # use:
    # spicetify config current_theme $THEME_NAME
    # spicetify auto backup apply
    notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: finished \"$config_name\" installation!"
    echo "[FINISHED]: theme installation"

    # restart
    notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: You can restart your WM now"
    echo You can restart your WM now.
    #bspc quit || openbox --exit
    #restart_applications $config_name
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



