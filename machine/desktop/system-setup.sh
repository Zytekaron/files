# Zytekaron's Arch Linux Installation Commands

exit # this file is not meant to be run as a script

# SHORTCUT STRINGS:
# !name = Arch repository dependency   pacman -S name
# ?name = AUR repository dependency    yay -S name
# @name = Custom install dependency    find the "@name installation" section in this file
# /<path> = Create and edit file (template or preconfigured version is at: https://files.zyte.dev/root/<path>)
# [shortcut] = Shortcut is an optional addition

############ Installation commands ############

# Setup network
pacman -S networkmanager
systemctl enable networkmanager

# Set root password
passwd # set password

# Create and setup user
useradd -m -G wheel z
passwd z # set password

################ User commands ################

# @yay installation !git !go !base-devel
cd /opt
sudo git clone https://aur.archlinux.org/yay
sudo chown -R z:users ./yay
cd yay
makepkg -si

# @z installation
curl -sfL https://files.zyte.dev/scripts/run/zget # verify content
curl -sfL https://files.zyte.dev/scripts/run/zget | sudo bash

# Configure and enable ufw !ufw
sudo ufw enable
sudo ufw allow ssh # only on simplesystems
sudo ufw allow http # any system is ok

# Optional rankmirrors @z !sudo !pacman-contrib
sudo z run arch/rankmirrorrs # wait 20-30 seconds

# Switch to the zsh shell !zsh
chsh -s /usr/bin/zsh # log out/in to apply changes

# Set default terminal editor !sudo
echo "export EDITOR=vim" | sudo tee /etc/profile.d/editor.sh
sudo chmod a+x /etc/profile.d/editor.sh

# OneDrive ?onedrive-abraunegg
#   /home/z/.config/onedrive/config
onedrive # login & input return uri
onedrive --synchronize --download-only
systemctl --user enable onedrive
systemctl --user start onedrive

# Agent configuration !ssh
#   /home/z/.ssh/config
#   /home/z/.config/systemd/user/ssh-agent.service
#   /home/z/.gnupg/gpg-agent.conf
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service

# Install and setup Nerd Fonts !git
git clone https://github.com/ryanoasis/nerd-fonts
cd nerd-fonts
sudo ./install.sh

# Configure git for development !git
git config --global init.defaultBranch master
git config --global user.email "zytekaron@gmail.com"
git config --global user.name "Michael Thornes"
git config --global user.signingKey 1748C7E588D0646C # gpg --list-keys --keyid-format LONG

# Setup supervisor services !sudo !supervisor
#   /etc/supervisord.conf
#   /etc/systemd/system/supervisord.service
sudo systemctl enable supervisord
sudo systemctl start supervisord
sudo vim /etc/supervisor.d/service-name.conf # creating services
sudo supervisorctl update all # to update when any daemon changes are made

# Configure U2F requirement for login !pam-u2f
mkdir ~/.config/solo
pamu2fcfg -u$(whoami) > ~/.ssh/u2f_keys
pamu2fcfg -n >> ~/.ssh/u2f_keys # for each subsequent key
# Configuring U2F PAM module:
#   Sudo password alternative: set first line of /etc/pam.d/sudo
#     auth		sufficient	pam_u2f.so cue [cue_prompt=» Waiting for U2F] origin=pam://atlas appid=pam://atlas authfile=.ssh/u2f_keys

################# Other steps #################

# Setup XBusKill
git clone https://github.com/Zytekaron/xbuskill
cd xbuskill
sudo make build install clean
touch ~/.xbuskill && chmod +x ~/.xbuskill

# Enable Discord's devtools and prevent the need for the latest update !discord
# Insert the following into ~/.config/discord/settings.json
#   "DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING": true,
#   "SKIP_HOST_UPDATE": true,

# Configure flameshot !flameshot
flameshot config # gui

# Configure keybinds:
# - PrtSc = `flameshot gui`
# - Mod+R = `dmenu_run -fn "Hack Nerd Font Mono:size=16:1"`
# - Menu  = `terminal-emulator`

# Configuring KVM & virt-manager
# - todo
