#!/bin/bash

set -e
# If something goes wrong this aborts the script

TIME=5

echo "Installing prerequisistes and building yay..."
sleep $TIME
# Displays and message and waits five seconds

sudo pacman -S --needed base-devel --noconfirm
# Downloads a package with important tools

if ! command -v yay &> /dev/null
# Checks if yay command exists
then
    echo "Installing yay (AUR helper)..."
    sleep $TIME
    # Displays message and waits
    YAY_DIR=$(mktemp -d)
    # Makes a temporary directory for yay
    git clone https://aur.archlinux.org/yay.git $YAY_DIR
    # Downloads yay to the directory it made
    (
        cd $YAY_DIR
        # Changes Directory (cd) to the yay directory
        makepkg -si --noconfirm
        # Builds yay with no confirmation
    )
    rm -rf $YAY_DIR
    # Removes those pesky temporary files
else
    echo "yay is already installed. Skipping installation."
    sleep $Time
    # If yay exists then it skips this step
fi
# if termination

echo "Installing packages..."
sleep $TIME
# Displays message and waits
sudo pacman -S --noconfirm \
  waybar fastfetch obsidian swaync syncthing \
  kitty nautilus wofi hyprpaper hypridle hyprshot btop \
  spotify-launcher otf-font-awesome --needed 
# That big chunk downloads all the pacman packages needed
yay -S --noconfirm \
  sublime-text-4 anydesk-bin brave-bin
# That chunk downloads all AUR (Arch User Repository) packages needed

echo "Configuration files about to be deployed..."
sleep $TIME
# Displays message and waits
stow */
# This creates a symbolic link that lets you keep all your configurations neatly organized

echo "Setting necessary execution permissions for scripts..."
sleep $TIME
# Uses the symlinked paths created by Stow
chmod +x ~/.config/hypr/scripts/Weather.sh
chmod +x ~/.config/hypr/startup.sh
chmod +x ~/.config/hypr/wofi-random-prompt.sh
# Gives some fun scripts privalges

echo ""
echo "--- SETUP COMPLETE! ---"
echo "REBOOT your system to ensure Hyprland starts correctly."
