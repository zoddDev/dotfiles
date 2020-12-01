#!/bin/bash

#ping archlinux.org &> /dev/null || echo '!' && exit 1
yay -Qu | wc -l
