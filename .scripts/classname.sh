#!/bin/bash

notify-send "$(xprop | grep 'CLASS')"
