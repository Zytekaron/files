# Zytekaron's Server Installation Commands
# Default OS: ubuntu
# Compatible: debian, arch

exit # this file is not meant to be run as a script

# SHORTCUT STRINGS:
# !name = Arch or apt repository dependency    apt install name   OR   pacman -S name
# ?name = AUR repository dependency            ----------------        yay -S name
# @name = Custom install dependency            find the "@name installation" section in this file
# /<path> = Create and edit file (template or preconfigured version is at: https://files.zyte.dev/root/<path>)
# [shortcut] = Shortcut is an optional addition

################ Root commands ################

# Setup doas !doas
groupadd wheel
echo "permit nopass :wheel as root" >> /etc/doas.conf

# Create and setup user
useradd -m -G wheel z
passwd z # set password

################ User commands ################

# @z installation
curl -sfL https://files.zyte.dev/scripts/run/zget # verify content
curl -sfL https://files.zyte.dev/scripts/run/zget | sudo bash

# Configure SSH authorized_keys
mkdir .ssh
chmod 700 .ssh
# create .ssh/authorized_keys with the public key here
chmod 644 .ssh/authorized_keys
# Modify /etc/ssh/sshd_config
#   PasswordAuthentication no
sudo systemctl restart sshd

# UBUNTU: Java installation
# - todo

# ARCH: Optional rankmirrors @z !pacman-contrib
sudo z run arch/rankmirrorrs # ~ 30 seconds

# ARCH: Install yay !git !go !base-devel
cd /opt
doas git clone https://aur.archlinux.org/yay
doas chown -R z:users ./yay
cd yay
makepkg -si
