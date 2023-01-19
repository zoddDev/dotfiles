#!/bin/bash

[[ $(cat /etc/os-release | grep arch) ]] && yay -Qu | wc -l
#[[ $(cat /etc/os-release | grep debian) ]] && apt list --upgradeable | wc -l

[[ $(cat /etc/os-release | grep debian) ]] && apt list --upgradable 2>/dev/null | wc -l
