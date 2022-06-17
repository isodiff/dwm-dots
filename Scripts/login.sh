#!/usr/bin/env bash

## kitty welcome window
(
kitty -1 -T="Hey, Hi, Hello" --wait-for-single-instance-window-close -d=/home/twfl/ /home/twfl/Scripts/./welcomelol.sh &
echo -e "$(date) started the kitty terminal window \n\n"
wait
echo -e "$(date) kitty terminal window stopped\n\n"
) &

## power manager
(
xfce4-power-manager &
echo -e "$(date) started the power manager \n\n"
wait
echo -e "$(date) power manager stopped\n\n"
) &

## wallpaper & xsetroot dwm bar
(
/home/twfl/Scripts/./wallpaper-switcher.sh &
echo -e "$(date) started the wallapper script \n\n"
/home/twfl/Scripts/dwm-bar/./dwm_bar.sh &
echo -e "$(date) started the dwm_bar script \n\n"
wait
echo -e "$(date) dwm_bar and wallpaper scripts stopped \n\n"
) &

## Audio servers and daemons
(
pipewire &
pipewire-pulse &
echo -e "$(date) started the audio server \n\n"
playerctld daemon &
echo -e "$(date) started the playerctl daemon \n\n"
wait
echo -e "$(date) audio servers and daemons stopped \n\n"
) &

## kdeconnect connection to android
(
sleep 2
kdeconnect-indicator &
sleep 1
kdeconnect-cli --refresh
kdeconnect-cli -l
kdeconnect-cli -a
kdeconnect-cli -d "2a8dc3a0d999f67f" --ping-msg="Asus Void is now online!"
echo -e "$(date) started the kdeconnect system \n\n"
wait
echo -e "$(date) kdeconnect system stopped \n\n"
)
