#!/bin/bash

set -xe

sudo mkdir /mnt/tank
sudo chown josef:josef /mnt/tank

ln -s /mnt/tank /home/josef/Tank
cp -r miscellaneous/icons /home/josef/Pictures/
