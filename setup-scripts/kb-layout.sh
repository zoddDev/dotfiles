#!/bin/bash

echo -n "Select your keyboard layout (e.g. us) " && read REPLY

[ -z $REPLY ]      && exit 1
setxkbmap "$REPLY" || exit 1

echo "[INFO]: Selected keyboard layout: $REPLY"
cp ./shared-config/.xinitrc $HOME
sed -i "s/setxkbmap es/setxkbmap $REPLY/g" $HOME/.xinitrc
