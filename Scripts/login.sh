#!/usr/bin/env bash

## kitty welcome window
kitty -1 -T="Hey, Hi, Hello" --wait-for-single-instance-window-close -d=/home/twfl/ /home/twfl/Scripts/./welcomelol.sh &
echo -e "$(date) started the kitty terminal window \n\n" &

## power manager
xfce4-power-manager &
echo -e "$(date) started the power power manager \n\n" &

## kdeconnect connection to android
kdeconnect-indicator &
kdeconnect-cli --refresh -l &
kdeconnect-cli -d "2a8dc3a0d999f67f" --ping-msg="Asus Void is now online!" &
echo -e "$(date) started the kdeconnect system \n\n" &

## wallpaper & xsetroot dwm bar
/home/twfl/Scripts/./wallpaper-switcher.sh &
echo -e "$(date) started the wallapper script \n\n" &
/home/twfl/Scripts/dwm-bar/./dwm_bar.sh &
echo -e "$(date) started the dwm_bar script \n\n" &

## Audio servers and daemons
pipewire &
pipewire-pulse &
echo -e "$(date) started the audio server \n\n" &
playerctld daemon &
echo -e "$(date) started the playerctl daemon \n\n" &
