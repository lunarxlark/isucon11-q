#!/bin/bash

sudo apt-get install -y netdata
sudo sed -i -e 's/bind socket to IP = 127.0.0.1/#bind socket to IP = 127.0.0.1/g' /etc/netdata/netdata.conf
sudo systemctl daemon-reload
sudo systemctl restart netdata.service