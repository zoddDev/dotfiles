#! /bin/bash

echo "[START]: theme installation..."

SETUP_ROOT="$(dirname "$PWD")"
arg=$1
copy_icons_and_themes=$2

function setup_config {
    # args
    config_name=$1
    spicetify_theme=$2
    
    # backup of .xinitrc and .bashrc
    cp $HOME/.xinitrc $HOME/.xinitrc-backup
    cp $HOME/.bashrc $HOME/.bashrc-backup

    notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: copying \"$config_name\" config files..."

    #
    # copying theme dotfiles
    #
    echo
    echo "[INFO]: applying \"$config_name\" theme..."

    cp -r $SETUP_ROOT/dotfiles/global-config/. $HOME &> /dev/null
    rm -rf $HOME/.oh-my-zsh/additional/* &> /dev/null || mkdir -p $HOME/.oh-my-zsh/additional &> /dev/null
    cp -r -a $SETUP_ROOT/dotfiles/themes/$config_name/. $HOME #&> /dev/null
    dconf load /org/gnome/gedit/ < $HOME/.config/gedit-dump.dconf
    [ -f $HOME/.config/fish/additional_config.fish ] && cat $HOME/.config/fish/additional_config.fish >> $HOME/.config/fish/config.fish

    #
    # configuring discord theme (beautifuldiscord)
    #
    #nohup $SETUP_ROOT/dotfiles/setup-scripts/set-discord-theme.sh &

    #
    # configuring spotify theme (spicetify)
    #
    #nohup $SETUP_ROOT/dotfiles/setup-scripts/set-spotify-theme.sh $spicetify_theme &

    echo "[FINISHED]: theme installation"
    notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: FINISHED! Enjoy your new theme :)"
}

shopt -s nocasematch
case "$arg" in 
    "gruvbox" ) setup_config "Gruvbox" "Gruvbox-Gold" ;; 
    "solarized-dark" ) setup_config "SolarizedDark" "SolarizedDark" ;; 
    "pink-nord" ) setup_config "PinkNord" "Nord" ;; 
    #"nord" ) setup_config "Nord" "Nord" ;; 
    *) echo "[ERROR]: no config with name \"$arg\" found" && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[ERROR]: Selected theme does not exist" && exit 1 ;;
esac



