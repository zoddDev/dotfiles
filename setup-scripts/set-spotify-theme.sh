#!/bin/bash

spicetify_theme=$1

#
# configuring spotify theme (spicetify)
#
echo 
echo "[INFO]: applying \"$spicetify_theme\" spicetify theme..."

$HOME/spicetify-cli/spicetify config current_theme $spicetify_theme
$HOME/spicetify-cli/spicetify apply

sleep 1
killall spotify

bspc desktop -f '^1' --follow
