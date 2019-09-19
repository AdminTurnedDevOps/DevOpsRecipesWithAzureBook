#!/bin/bash
echo "Download PowerShell repo"
wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.d\eb
echo "Registering repo"
sudo dpkg -i packages-microsoft-prod.deb

sudo apt-get update -y

echo "Installing PowerShell"
sudo apt-get install -y powershell

poshVersion='pwsh --version'