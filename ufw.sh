#!/bin/bash

sudo ufw reset
sudo ufw enable

sudo ufw default deny incoming
sudo ufw default deny routed
sudo ufw default allow outgoing

# Allow SSH all
sudo ufw allow from 0.0.0.0/0 to any port 22 proto tcp
sudo ufw allow from ::/0 to any port 22 proto tcp

# Allow samba for KVM-Qemu VMs
sudo ufw allow from 192.168.122.0/24 to any port 139 proto tcp
sudo ufw allow from 192.168.122.0/24 to any port 445 proto tcp

sudo ufw deny 22
sudo ufw deny 139
sudo ufw deny 445

