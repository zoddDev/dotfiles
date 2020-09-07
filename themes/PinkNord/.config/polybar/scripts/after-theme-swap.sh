#!/bin/bash

function restart_applications {
    # args
    config_name=$1

    # kill applications
    killall dunst &
    killall compton &
    #killall sxhkd &
    killall dropbox &
     
    # restart applications
    #compton &
    #dunst &
    #pkill -USR1 -x sxhkd &

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

        *) nitrogen --restore ;;
    esac

    bspwm_running=`ps -e | grep bspwm | wc -l` 

    if [ $bspwm_running > 0 ]; 
    then
        killall bspc 
        killall bspwmrc 
        killall bspswallow
        killall polybar

        case "$arg" in 
            "gruvbox" ) bspc monitor -d    ﳁ   ﭮ   & ;;
            "*nord" ) bspc monitor -d 一 二 三 四 五 六 七 八 九 十 & ;;
            *) bspc monitor -d    ﳁ   ﭮ   & ;;
        esac

        $HOME/.scripts/autostart.bspwm &
        xsetroot -cursor_name left_ptr &
        #sxhkd &
        compton &
        nitrogen --restore &
        polybar example &
        wmname LG3D &
        lxpolkit &
        xset -dpms s off & # disable screen blanking &
        dunst &
        $HOME/.config/bspwm/bspborders &
        pidof $HOME/.scripts/bspswallow || $HOME/.scripts/bspswallow &
        dropbox &
        $HOME/.config/bspwm/autostart
    fi

    killall kitty
    bspc rule -a \* -o state=floating && sleep 0.015 
    kitty -e /bin/fish -C neofetch &
}

restart_applications $1
