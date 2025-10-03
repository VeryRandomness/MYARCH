#!/bin/bash

set -e
# The above command terminates the bash script if something goes wrong

REPO="https://github.com/VeryRandomness/MYARCHY"
INSTDIR="$HOME/Dotfiles"
# The above two lines define what github repository to grab from and where all the files will be installed.
# They aren't expressly needed but do make it nice
TIME=5
# Defines how long the waits should be. Added to make the install faster if needed by modifiying the variable.

echo "--- STARTING AUTOMATED ARCH CONFIGURATION ---"
sleep $Time
# This just displays a message for 5 seconds

sudo sed -i '/#Misc/aILoveCandy' /etc/pacman.conf
# The most imporant comman. This makes the progress bars Pacman

echo "Installing utilities: Sudo, git, and stow..."
sleep $Time
# This tells you what is beings installed and waits 5 seconds
pacman -Syu --noconfirm sudo
# Installs sudo without needing to confirm
sudo pacman -S --needed git stow --noconfirm
# Installs git and stow, confirms we don't already have them, doesn't need confirmation

if [ ! -d "$INSTDIR" ]; then
# Checks if the correct directory exists and continues
  echo "Cloning dotfiles repository to $INSTDIR" 
  sleep $Time
  # Display message and waits
  git clone $REPO $INSTDIR
  # Downloads the repository into the correct directory
else
  echo "Dotfiles directory $INSTDIR already exists. Aborting download."
  sleep $Time
  # If the directory already exists then in cancels the download
fi
# if termination

echo "Installing..."
sleep $Time
# Displays message and waits
cd $INSTDIR
# Changes the Directory (cd) to the correct directory (so all configuration files will be in the same place).
if [ -f "install.sh" ]; then
# Checks if install.sh exists
  bash ./install.sh
  # runs is
else
  echo "Error: Install script not found in repository. Aborting"
  sleep $Time
  exit 1
  # If instal.sh doesn't exist then it aborts
fi
