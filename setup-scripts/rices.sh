#! /bin/bash

echo "[START]: theme installation..."

SETUP_ROOT="$(dirname "$PWD")"
arg=$1
copy_icons_and_themes=$2
echo $SETUP_ROOT

function setup_config {
    replace_user="zodd"
    # args
    config_name=$1

    [ -z "$(ls -a ./rices/$config_name | grep -v -w '^\.')" ] && ./setup-scripts/download-rice.sh $config_name
    
    # backup of .xinitrc, .bashrc and .zshrc
    cp $HOME/.xinitrc $HOME/.xinitrc-backup
    cp $HOME/.bashrc $HOME/.bashrc-backup
    cp $HOME/.zshrc $HOME/.zshrc-backup

    nohup notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: copying \"$config_name\" config files..." &

    #
    # copying theme dotfiles
    #
    echo
    echo "[INFO]: applying \"$config_name\" theme..."

    #nohup cp -r $SETUP_ROOT/dotfiles/shared-config/. $HOME &> /dev/null
    rm -rf $HOME/.oh-my-zsh/additional/* &> /dev/null
    dconf load /org/gnome/gedit/ < $HOME/.config/gedit-dump.dconf
    rsync -rav $SETUP_ROOT/dotfiles/rices/$config_name/. $HOME
    sed -i "s/$replace_user/$USER/g" $HOME/.config/nitrogen/*.cfg

    #
    # configuring discord theme (beautifuldiscord)
    #
    #nohup $SETUP_ROOT/dotfiles/setup-scripts/set-discord-theme.sh &

    #
    # configuring spotify theme (spicetify)
    #
    #nohup $SETUP_ROOT/dotfiles/setup-scripts/set-spotify-theme.sh &

    echo "[FINISHED]: theme installation"
    #nohup notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[INFO]: FINISHED! Enjoy your new theme :)" &

    rm $HOME/README.md > /dev/null

    nohup nvim -E -s -u "$HOME/.config/nvim/init.vim" +PlugInstall +qall &

    exit 0
}

shopt -s nocasematch
case "$arg" in 
    "gruvbox" ) setup_config "Gruvbox" ;; 
    "solarized-dark" ) setup_config "SolarizedDark" ;; 
    "pink-nord-alternative" ) setup_config "PinkNordAlternative" ;; 
    "pink-nord" ) setup_config "PinkNord" ;; 
    "horizon" ) setup_config "Horizon" ;; 
    "bw" ) setup_config "BW" ;; 
    "ayu" ) setup_config "Ayu" ;; 
    "nord" ) setup_config "Nord" ;; 
    *) echo "[ERROR]: no config with name \"$arg\" found" && notify-send -i $SETUP_ROOT/dotfiles/setup-scripts/resources/white-brush.png "[ERROR]: Selected theme does not exist" & ;;
esac

exit 1



