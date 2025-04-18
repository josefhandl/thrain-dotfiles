#!/bin/bash

set -ex

cp -r windows/icons /home/josef/.local/share/

# Install Win11 launch icons
sudo cp windows/win11-thror-* /usr/share/applications/

# Install Gnome extension for Win11 VM management
cp -r 'windows/win-vm-status@josefhandl' /home/josef/.local/share/gnome-shell/extensions/
