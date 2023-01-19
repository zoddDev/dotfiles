#!/bin/bash

echo "[START]: Display Manager installation..."

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/ && sudo cp ./getty-dm/override.conf /etc/systemd/system/getty@tty1.service.d/override.conf

sudo sed -i "s/zodd/$USER/g" /etc/systemd/system/getty@tty1.service.d/override.conf

echo "[FINISHED]: Display Manager installation"
