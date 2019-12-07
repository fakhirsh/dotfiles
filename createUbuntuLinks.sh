#!/bin/sh

echo "Creating Ubuntu Hard Links..."
echo "-----------------------------"

mkdir ubuntu 2> /dev/null # supressing errors/warnings
cd ubuntu

echo "Creating .vimrc hard link"
ln ~/.vimrc .vimrc 2> /dev/null
echo "Creating .i3status.conf hard link"
ln ~/.i3status.conf .i3status.conf 2> /dev/null

mkdir .config 2> /dev/null
cd .config

echo "Creating compton.conf hard link"
ln ~/.config/compton.conf compton.conf 2> /dev/null

mkdir i3 2> /dev/null
cd i3

echo "Creating i3/config hard link"
ln ~/.config/i3/config config 2> /dev/null


echo "Done..."
