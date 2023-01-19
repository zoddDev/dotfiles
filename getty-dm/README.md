# getty minimal display manager

## Installation
```
yay -S mingetty
```

## Replace username in override.conf
```
ExecStart=-/usr/bin/agetty --skip-login --login-options USERNAME --noclear %I $TERM
```

## Copy override.conf to its config directory
```
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/ && sudo cp override.conf /etc/systemd/system/getty@tty1.service.d/override.conf
```

## Enable service
```
systemctl start getty@ttyN.service
```
