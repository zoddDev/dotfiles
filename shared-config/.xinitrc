#!/bin/bash

setxkbmap es
xsetroot -cursor_name left_ptr

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xset +fp /usr/share/fonts/local &
xset fp rehash &
xrdb ~/.Xresources &
xsetroot -cursor_name left_ptr &
exec bspwm

#source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK
#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
