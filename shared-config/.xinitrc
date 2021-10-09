#!/bin/bash

setxkbmap es

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec bspwm

#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session

