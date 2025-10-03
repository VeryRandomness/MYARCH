#!/bin/bash

/usr/lib/lxsession/main/lxpolkit &

# Start Waybar, SwayNC, and other services in the background
waybar &
hyprpaper &
hypridle &
hyprshot &

# Give swaync a moment to start up and listen for notifications
sleep 2
swaync &

# Start other services
