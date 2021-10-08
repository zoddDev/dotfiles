#!/bin/bash

function update {
    pacman_arg=$1
    output_file=$2

    EXCLUDE='(systemd|^themix|nativefier|^resvg|discord|spotify|skype|virtualbox|dropbox|etcher-bin|chromium|libsoup3|telegram|code)'

    sudo pacman -$pacman_arg | grep -Ev $EXCLUDE | cut -d ' ' -f 1 > $DOTFILES/setup-scripts/resources/$output_file
}

arg=$1

if [ "$arg" = "aur" ];
then 
    update 'Qm' 'aur-packages'
elif [ "$arg" = "pacman" ];
then
    update 'Qn' 'pacman-packages'
elif [ "$arg" = "all" ];
then
    update 'Qm' 'aur-packages'
    update 'Qn' 'pacman-packages'
else
    echo "No option named: \"$arg\""
    echo "No packages list to update, exiting..."
    exit
fi

