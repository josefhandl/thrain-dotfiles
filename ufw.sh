#!/bin/bash

sudo ufw reset
sudo ufw enable

sudo ufw default deny incoming
sudo ufw default deny routed
sudo ufw default allow outgoing

sudo ufw allow from 0.0.0.0/0 to any port 22 proto tcp
sudo ufw allow from ::/0 to any port 22 proto tcp

sudo ufw deny 22
