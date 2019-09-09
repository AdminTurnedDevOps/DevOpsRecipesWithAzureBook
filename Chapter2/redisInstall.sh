#!/bin/bash
sudo apt update -y
sudo apt-get install redis-server -y
sudo systemctl enable redis-server.service -y