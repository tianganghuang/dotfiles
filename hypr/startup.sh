#!/usr/bin/env bash

# wallpaper daemon
swww init &
swww img ~/Downloads/444970.jpg &

# network indicator
nm-applet --indicator &

# bar
waybar &

dunst
