#! /bin/bash

echo "[START]: theme installation..."

SETUP_ROOT="$(dirname "$PWD")"
arg=$1

function restart_applications {
    # args
    config_name=$1

    # kill
    killall dunst &
    killall polybar &
    killall compton &
     
    # restart
    compton &
    dunst &
    pkill -USR1 -x sxhkd &

    case "$arg" in 
        "doombox" ) 
            feh --bg-fill $HOME/Pictures/Wallpapers/Wallpapers/doom-theme/Doom-Eternal_Maurader_Wallpaper_3840x2160-01.jpg &
            $HOME/.config/polybar/launch.sh & ;;        

        "alternative-gruvbox" ) 
            feh --bg-fill $HOME/Pictures/Wallpapers/Wallpapers/gruvbox-theme/randall-mackey-mural2.jpg &
            $HOME/.config/polybar/launch.sh & ;; 

        "solarized-dark" ) 
            feh --bg-fill $HOME/Pictures/Wallpapers/Wallpapers/vaporwave-theme/palms.jpg &
            $HOME/.config/polybar/launch.sh & ;; 

        "dracula" ) 
            feh --bg-fill $HOME/Pictures/Wallpapers/Wallpapers/dracula-theme/dracula-purplish.png &
            polybar example & ;;

        "gruvbox" ) 
            feh --bg-fill $HOME/Pictures/Wallpapers/Wallpapers/gruvbox-theme/wallhaven-ym8937.jpg &
            polybar example & ;;
    
        *) echo "[ERROR]: no config with name \"$arg\" found" && exit 1 ;;
    esac
}

function setup_config {
    # args
    config_name=$1
    spicetify_theme=$2
    beautifuldiscord_theme=$3
    
    # backup of .xinitrc and .bashrc
    cp $HOME/.xinitrc $HOME/.xinitrc-backup
    cp $HOME/.bashrc $HOME/.bashrc-backup

    #
    # copying theme dotfiles
    #
    echo
    echo "[INFO]: applying \"$config_name\" theme..."

    sudo cp -r -a $SETUP_ROOT/dotfiles/themes/$config_name/. $HOME

    #
    # restarting applications
    #
    echo
    echo "[INFO]: restarting some applications..."

    #restart_applications $config_name

    #
    # configuring spotify theme (spicetify)
    #
    echo 
    echo "[INFO]: applying \"$config_name\" spicetify theme..."

    fish -C spicetify config current_theme $spicetify_theme &
    sleep 5
    fish -C spicetify apply &

    #
    # configuring discord theme (beautifuldiscord)
    #
    echo 
    echo "[INFO]: applying \"$config_name\" beautiful-discord theme..."

    discord > /dev/null & 
    sleep 5 
    python -m beautifuldiscord --css $HOME/.config/discord/themes/$beautifuldiscord_theme

    # restart

    bspc quit || openbox --exit
}

cp -r ../.scripts $HOME
sudo cp ../environment /etc/environment
[ -d $HOME/Pictures/Wallpapers ] || mkdir -p $HOME/Pictures/Wallpapers
cp -r ../Wallpapers $HOME/Pictures/Wallpapers
cp -r ../.fonts $HOME
cp -r ../.icons $HOME
cp -r ../.themes $HOME

shopt -s nocasematch
case "$arg" in 
    "doombox" ) setup_config "DOOMBOX" "Gruvbox-Gold" "Duvbox/duvbox.css" ;; 
    "gruvbox" ) setup_config "Gruvbox" "Gruvbox-Gold" "Duvbox/duvbox.css" ;; 
    "alternative-gruvbox" ) setup_config "AlternativeGruvbox" "Gruvbox-Gold" "Duvbox/duvbox.css" ;; 
    "solarized-dark" ) setup_config "SolarizedDark" "SolarizedDark" "SolarizedDark/solarized_dark.css" ;; 
    "dracula" ) setup_config "Dracula" "Dracula" "Dracula/discord-dracula.css" ;; 
    "nord" ) setup_config "Nord" "Nord" "Nord/discord-nord.css" ;; 

    *) echo "[ERROR]: no config with name \"$arg\" found" && exit 1 ;;
esac

echo "[INFO]: You maybe also need to manually set the beautiful-discord and spicetify theme separately if their installations didn't work properly"
# use:
# spicetify config current_theme $THEME_NAME
# spicetify auto backup apply
echo "[FINISHED]: theme installation (success!)"


