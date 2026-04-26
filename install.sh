#!/bin/bash

# Colors for the drama
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

echo -e "${PURPLE}--- Spring Sway Rice: Operation 'Make My PC Pretty' ---${NC}"
echo -e "${BLUE}Disclaimer: I am not responsible if your PC starts judging your taste in wallpapers.${NC}"

# 1. Installing dependencies
echo -e "${GREEN}[1/4] Gathering ingredients for the rice... Please wait while I hoard packages.${NC}"
sudo pacman -S --needed sway waybar swaylock swayidle wofi mako alacritty \
    grim slurp wl-copy light polkit-gnome brightnessctl \
    pavucontrol thunar ttf-jetbrains-mono ttf-font-awesome \
    swaybg network-manager-applet python-pip --noconfirm

# AUR Helper check
if ! command -v yay &> /dev/null; then
    echo -e "${BLUE}Wait, you don't have 'yay'? How do you even live? Fixing your life now...${NC}"
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay && makepkg -si --noconfirm
    cd -
fi

echo -e "${GREEN}Installing AUR stuff. Go grab a coffee, this might take a bit.${NC}"
yay -S autotiling swaylock-effects-git --noconfirm

# 2. Cloning the repo
echo -e "${GREEN}[2/4] Stealing... I mean, 'borrowing' Tolepi's hard work from GitHub.${NC}"
REPO_DIR="$HOME/spring-sway-rice"
if [ -d "$REPO_DIR" ]; then
    echo -e "${BLUE}Detected an old repo folder. Deleting it like an ex's photos.${NC}"
    rm -rf "$REPO_DIR"
fi
git clone https://github.com/Tolepi/spring-sway-rice.git "$REPO_DIR"

# 3. Backup and Move
echo -e "${GREEN}[3/4] Moving files around. Your old configs are being sent to a farm upstate.${NC}"
mkdir -p "$HOME/.config/old_configs_backup"

configs=(sway waybar mako wofi alacritty)

for conf in "${configs[@]}"; do
    if [ -d "$HOME/.config/$conf" ]; then
        mv "$HOME/.config/$conf" "$HOME/.config/old_configs_backup/"
    fi
    cp -r "$REPO_DIR/.config/$conf" "$HOME/.config/"
done

if [ -d "$REPO_DIR/wallpapers" ]; then
    echo -e "${BLUE}Copying wallpapers. Try to pick a nice one, okay?${NC}"
    cp -r "$REPO_DIR/wallpapers" "$HOME/Pictures/"
fi

# 4. Finish
echo -e "${GREEN}[4/4] Done! Your OS is now officially cooler than you are.${NC}"
echo -e "${PURPLE}--------------------------------------------------${NC}"
echo -e "Final Instructions for Humans:"
echo -e "1. Edit ~/.config/sway/config unless you enjoy weird keyboard layouts."
echo -e "2. Log out, select 'Sway', and pray to the Linux gods."
echo -e "3. If it doesn't work, have you tried turning it off and on again?"
