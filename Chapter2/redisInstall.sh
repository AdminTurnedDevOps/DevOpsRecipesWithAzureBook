#!/bin/bash
sudo apt update -y
sudo apt-get install redis-server
sudo systemctl enable redis-server.service