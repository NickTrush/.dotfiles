#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc

sed -i '177s/.//' /etc/locale.gen 
sed -i '403s/.//' /etc/locale.gen 
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf

read -p "Enter machine hostname: " hostname
echo $hostname >> /etc/hostname
echo "127.0.0.1\tlocalhost" >> /etc/hosts
echo "::1\t\tlocalhost" >> /etc/hosts
echo "127.0.1.1\t$2.localdomain\t$2" >> /etc/hosts

read -sp "Enter new root user password: " newrootpasswd
echo root:$newrootpasswd | chpasswd

read -p "Enter your username: " username
read -p "Enter your full name: " userfullname
read -sp "Enter your new password: " newuserpasswd


pacman -S --noconfirm grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools reflector base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pulseaudio bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra ovmf bridge-utils dnsmasq vde2 openbsd-netcat ebtables iptables ipset firewalld flatpak sof-firmware nss-mdns acpid

# pacman -S --noconfirm xf86-video-amdgpu
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable tlp
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable firewalld
systemctl enable acpid




useradd -mG $username
usermod -c $userfullname $username
echo $username:$newuserpasswd | chpasswd

echo "$username ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/$username

/bin/echo -e "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
