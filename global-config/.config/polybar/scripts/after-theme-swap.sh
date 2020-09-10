#!/bin/bash

function restart_applications {
    config_name=$1

    # ------ kill applications ------
    killall polybar &
    killall dunst &
    #killall compton &
     
    # ------ restart applications ------
    nitrogen --restore
    bspwm_running=`ps -e | grep bspwm | wc -l` 

    if [ $bspwm_running -gt 0 ]; 
    then
        killall bspc 
        killall bspwmrc 
        killall bspswallow

        $HOME/.config/bspwm/autostart &
        xsetroot -cursor_name left_ptr &
        #compton &
        nitrogen --restore &
        dunst &
        $HOME/.config/bspwm/bspborders &
        pidof $HOME/.scripts/bspswallow || $HOME/.scripts/bspswallow &
        $HOME/.config/bspwm/autostart &
    fi
    
    killall kitty
    nohup $HOME/.config/polybar/scripts/restart-polybar.sh &
    sleep 0.3
    nohup floating-term-bspwm.sh
}

restart_applications $1
