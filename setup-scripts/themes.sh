#! /bin/bash

echo "[START]: theme installation..."

SETUP_ROOT="$(dirname "$PWD")"
arg=$1

function setup_config {
   config_name=$1 
   echo "[INFO]: applying \"$config_name\" theme..."

   cp -r $SETUP_ROOT/themes/$config_name/* $HOME
}

shopt -s nocasematch
case "$arg" in 
    "doombox" ) setup_config "DOOMBOX";; 
    "alternative-gruvbox" ) setup_config "AlternativeGruvbox";; 
    "solarized-dark" ) setup_config "SolarizedDark";; 

    *) echo "[ERROR]: no config with name \"$arg\" found" && exit 1 ;;
esac

echo "[FINISHED]: theme installation (success!)"
