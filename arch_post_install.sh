#!/bin/bash

#
#   Fakhir Shaheen
#   Arch Linux Installation Script
#   Copyright (c) 2020
#
#   Second part of the installation script to be run after installation
#       
#

echo ""
echo "--=[ Executing Phase 2: Ricing Arch ]=--"
echo ""

echo "Installing more development tools"
sudo pacman -S vim git cmake 

echo "Installing tools for ricing"
sudo pacman -S lightdm i3-wm i3status i3lock xorgserver 
