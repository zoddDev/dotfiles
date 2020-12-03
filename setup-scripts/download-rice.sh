#!/bin/bash

theme_name=$1
[ ! -z $theme_name ] && cd ./themes/$theme_name && git submodule update --init .
