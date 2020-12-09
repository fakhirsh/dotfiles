#!/bin/bash

#
#   Fakhir Shaheen
#   Arch Linux Installation Script
#   Copyright (c) 2020
#
#   Second part of the installation script to be run after
#       arch-chroot (i.e inside the root environment)
#
#   TODO: Check the following to possibly combine these two scripts together:
#   https://www.reddit.com/r/archlinux/comments/bssbze/scripting_into_chroot/
#

echo ""
echo "--=[ Executing Phase 2: The Root Environment ]=--"
echo ""

echo "Configuring Locale"
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /mnt/etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /mnt/etc/locale.conf
export LANG=en_US.UTF-8

echo "Setting up timezone"
ln -sf /usr/share/zoneinfo/Asia/Karachi /mnt/etc/localtime
hwclock --systohc
timedatectl set-timezone Asia/Karachi

echo "Installing extra packages"
pacman -S zsh grub-bios vim git

echo "Configuring users"
read -p "Enter User Name: " USERNAME
echo -n "Enter Password: "
read -s PASSWORD1
echo
echo -n "Repeat Password: "
read -s PASSWORD2
echo
[[ "$PASSWORD1" == "$PASSWORD2" ]] || ( echo "Passwords did not match"; exit 1; )
read -p "Enter Host Name: " HOSTNAME

echo "Setting hostname"
echo "$HOSTNAME" > /mnt/etc/hostname

echo "Configuring users"
echo "    Creating new user"
useradd -m -g wheel -s /bin/zsh "$USERNAME"
echo "$USERNAME:$PASSWORD1" | chpasswd
echo "    Changing root password"
echo "root:$PASSWORD1" | chpasswd --root /mnt
unset PASSWORD1 PASSWORD2

echo "Modifying sudoers"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /mnt/etc/sudoers

echo "Modifying grub config"
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="cryptdevice=\/dev\/sda2:cryptroot"/g' /mnt/etc/default/grub

echo "Modifying mkinitcpio.conf"
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)/g' /mnt/etc/mkinitcpio.conf

mkinitcpio -p linux

