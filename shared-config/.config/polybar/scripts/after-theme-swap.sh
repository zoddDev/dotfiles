#!/bin/bash

function restart_applications {
    config_name=$1

    # ------ kill applications ------
    killall -9 polybar &
    killall dunst &
    killall -9 compton &
    killall -9 picom &
     
    # ------ restart applications ------
    nitrogen --restore
    bspwm_running=`ps -e | grep bspwm | wc -l` 

    if [ $bspwm_running -gt 0 ]; 
    then
        killall bspc 
        killall bspwmrc 
        #killall bspswallow

        $HOME/.config/bspwm/autostart &
        xsetroot -cursor_name left_ptr &
        picom &
        nitrogen --restore &
        dunst &
        nohup pidof $HOME/.scripts/bspswallow || $HOME/.scripts/bspswallow &
        $HOME/.config/bspwm/autostart &

        cp $HOME/.config/polybar/config.bspwm $HOME/.config/polybar/config
    fi

    /bin/neofetch --clean &
    
    killall kitty
    nohup $HOME/.config/polybar/scripts/restart-polybar.sh &

    sleep 0.3
    rm $HOME/.config/sxhkd/sxhkdrc.*
    rm $HOME/.config/polybar/config.*
    nohup floating-term-bspwm.sh &
}

restart_applications $1
