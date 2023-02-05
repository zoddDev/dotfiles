#!/bin/bash

restart_applications () {
    config_name=$1

    # ------ kill applications ------
    killall -9 polybar
    killall dunst
    killall -9 compton
    killall -9 picom
     
    # ------ restart applications ------
    nitrogen --restore
    bspwm_running=`ps -e | grep bspwm | wc -l` 

    if [ $bspwm_running -gt 0 ]; 
    then
        killall bspc 
        killall bspwmrc 
        killall bspswallow

        # Some default bspwm config (can be overriden by ~/.config/bspwm/autostart)
        bspc config window_gap          20
        bspc config split_ratio          0.6
        bspc config borderless_monocle   true
        bspc config gapless_monocle      true
        bspc config single_monocle       false

        ~/.config/bspwm/autostart &
        xsetroot -cursor_name left_ptr &
        picom &
        nitrogen --restore &
        dunst &
        #nohup pidof $HOME/.scripts/bspswallow || $HOME/.scripts/bspswallow &
        
        pgrep bspswallow || nohup ~/.scripts/bspswallow &
        ~/.config/bspwm/autostart &

        cp ~/.config/polybar/config.bspwm ~/.config/polybar/config
    fi

    /bin/neofetch --clean &
    
    nohup ~/.config/polybar/scripts/launch-polybar.sh &

    sleep 0.3
    rm ~/.config/sxhkd/sxhkdrc.*
    rm ~/.config/polybar/config.*

    # Reload config for all kitty instances
    pkill -SIGUSR1 kitty
    floating-term-bspwm.sh
}

restart_applications $1
