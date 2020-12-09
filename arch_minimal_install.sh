#!/bin/bash

#
#   Fakhir Shaheen
#   Arch Linux Installation Script
#   Copyright (c) 2020
#
#   Download the archiso image from https://www.archlinux.org/download/
#   Burn to a usb-drive:
#   dd bs=4M if=archlinux.iso of=/dev/sdx status=progress oflag=sync
#
#   If using VirtualBox, enable Port Forwarding:
#   https://www.techrepublic.com/article/how-to-use-port-forwarding-in-virtualbox/
#
#   Automated installation guide:
#   https://shirotech.com/linux/how-to-automate-arch-linux-installation/
#   
#   Set password on the installation system:
#   > passwd
#
#   Start ssh service:
#   > systemctl start sshd
#
#   Then connect to the installation system using ssh:
#   > ssh -p 2222 root@127.0.0.1
#           In case of errors on the client PC, remove entries from:
#           > vim .ssh/known_hosts
#   
#   Copy scripts over through new port;
#   > scp -P 2222 arch_install.sh root@127.0.0.1:/root
#

echo ""
echo "---=={[ Welcome to Fakhir's Arch Linux Automated Installation ]}==---"
echo ""
echo "--=[ Executing Phase 1: The Pre-installation Process ]=--"
echo ""

echo "Configuring Time"
echo "    Updating system clock"
timedatectl set-ntp true

echo "Initializing Partitions"
parted --script /dev/sda -- mklabel msdos mkpart primary fat32 1Mib 201Mib set 1 boot on mkpart primary ext4 201Mib 100%


echo "    Setting up LUKS"
cryptsetup -y -v luksFormat /dev/sda2 
cryptsetup open /dev/sda2 cryptroot

echo ""
echo "Configuring users"
read -p "    Enter User Name: " USERNAME
echo -n "    Enter Password: "
read -s PASSWORD1
echo
echo -n "    Repeat Password: "
read -s PASSWORD2
echo
[[ "$PASSWORD1" == "$PASSWORD2" ]] || ( echo "Passwords did not match"; exit 1; )
read -p "    Enter Host Name: " HOSTNAME

echo "    Format the  /boot partition"
mkfs.ext4 -F -L boot /dev/sda1
echo "    Format the / partition"
mkfs.ext4 -F /dev/mapper/cryptroot

echo "    Mounting Partitions"
mount -t ext4 /dev/mapper/cryptroot /mnt
mkdir /mnt/boot
mount -t ext4 /dev/sda1 /mnt/boot

echo "Sorting Arch mirrors"
reflector --verbose --latest 13 --sort rate --save /etc/pacman.d/mirrorlist 

echo "Installing Arch Linux"
pacstrap /mnt base base-devel linux linux-firmware

echo "Updating Filesystem Table"
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "Changing to root"
arch-chroot /mnt /bin/bash <<EOF
echo ""
echo "--=[ Executing Phase 2: The Root Environment ]=--"
echo ""

echo "Configuring Locale"
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8

echo "Setting up timezone"
ln -sf /usr/share/zoneinfo/Asia/Karachi /etc/localtime
hwclock --systohc
timedatectl set-timezone Asia/Karachi

#-----------------------------------------------------------
echo "Installing extra packages"
pacman --noconfirm -S zsh grub-bios
#-----------------------------------------------------------

echo "Setting hostname"
echo "$HOSTNAME" > /mnt/etc/hostname

echo "Configuring users"
echo "    Creating new user"
useradd -m -g wheel -s /bin/zsh "$USERNAME"
echo "$USERNAME:$PASSWORD1" | chpasswd
echo "    Changing root password"
echo "root:$PASSWORD1" | chpasswd
unset PASSWORD1 PASSWORD2

echo "Modifying sudoers"
sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /etc/sudoers

echo "Modifying grub config"
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="cryptdevice=\/dev\/sda2:cryptroot"/g' /etc/default/grub

echo "Modifying mkinitcpio.conf"
sed -i 's/HOOKS=(base udev autodetect modconf block filesystems keyboard fsck)/HOOKS=(base udev autodetect modconf block encrypt filesystems keyboard fsck)/g' /etc/mkinitcpio.conf

echo "Regenerating Ramdisk"
mkinitcpio -p linux

echo "Installing grub"
grub-install --recheck /dev/sda
grub-mkconfig --output /boot/grub/grub.cfg

echo "Createing Swap File"
fallocate -l 8G /swapfile
chmod 600 /swapfile         # change permisions
mkswap /swapfile            # asign it as a swap file
echo '/swapfile none swap sw 0 0' | tee -a /etc/fstab  # add into file systemtable
    
echo "Enabling Network Interfaces"
pacman --noconfirm -S networkmanager
systemctl enable NetworkManager

exit
EOF

echo "Rebooting..."
umount -R /mnt/boot
umount -R /mnt
cryptsetup close cryptroot
systemctl reboot


