#!/bin/bash

function restart_applications {
    # args
    config_name=$1

    # kill applications
    killall dunst &
    killall compton &
    killall polybar &
    killall dropbox &
     
    # restart applications
    nitrogen --restore
    bspwm_running=`ps -e | grep bspwm | wc -l` 

    if [ $bspwm_running > 0 ]; 
    then
        killall bspc 
        killall bspwmrc 
        killall bspswallow
        killall polybar

        $HOME/.config/bspwm/autostart &
        xsetroot -cursor_name left_ptr &
        nohup compton &
        nohup nitrogen --restore &
        nohup polybar example &
        nohup wmname LG3D &
        nohup lxpolkit &
        nohup xset -dpms s off & # disable screen blanking &
        nohup dunst &
        nohup $HOME/.config/bspwm/bspborders &
        nohup pidof $HOME/.scripts/bspswallow || $HOME/.scripts/bspswallow &
        nohup dropbox &
        nohup $HOME/.config/bspwm/autostart &
    fi

    killall kitty
}

restart_applications $1
