#!/bin/sh

echo "Creating Hard Links..."
echo "-----------------------------"

echo "Creating .vimrc hard link"
ln ~/.vimrc .vimrc 2> /dev/null       # supressing errors/warnings
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

cd ..
cd ..

echo "Creating XBindKeys hard link"
ln ~/.xbindkeysrc .xbindkeysrc 2> /dev/null

echo "Creating .xinitrc hard link"
ln ~/.xinitrc .xinitrc 2> /dev/null

echo "Creating XRandr Screen Layout hard link"
mkdir .screenlayout 2> /dev/null
cd .screenlayout
ln ~/.screenlayout/mylayout.sh mylayout.sh 2> /dev/null

echo "Done..."
