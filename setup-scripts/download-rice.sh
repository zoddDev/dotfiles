#!/bin/bash

theme_name=$1
[ ! -z $theme_name ] && cd $DOTFILES/themes/$theme_name && git submodule update --init .
