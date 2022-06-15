#!/bin/bash
LOGDIR=$HOME"/Scripts/logs"

# Dwm bar xsetroot
(
echo -e "\n\n"
bash /home/twfl/Scripts/dwm-bar/dwm_bar.sh &
echo -e "$(date) started the dwm_bar script \n\n" &
) 2>&1 | tee -a $LOGDIR/scripts.log &

# Start audio servers
(
sleep 2
echo -e "\n\n"
(pipewire) &
(pipewire-pulse) &
echo -e "$(date) started the audio server \n\n" &
) 2>&1 | tee -a $LOGDIR/scripts.log &

# Playerctl deamon for music status
(
echo -e "\n\n"
playerctld daemon
echo -e "$(date) started the playerctl daemon \n\n" &
) 2>&1 | tee -a $LOGDIR/scripts.log &



# Set a wallaper
(
sleep 2
echo -e "\n\n"
bash /home/twfl/Scripts/wallpaper-switcher.sh &
echo -e "$(date) started the wallapper script \n\n" &
) 2>&1 | tee -a $LOGDIR/scripts.log &


# Open the kitty terminal
(
sleep 2
echo -e "\n\n"
kitty -1 -T="Hey, Hi, Hello" --wait-for-single-instance-window-close -d=/home/twfl/ bash /home/twfl/Scripts/welcomelol.sh &
echo -e "$(date) started the kitty terminal window \n\n" &
) 2>&1 | tee -a $LOGDIR/scripts.log &

# Open Browser
(
sleep 2
echo -e "\n\n"
ungoogled-chromium &
echo -e "$(date) started the browser \n\n" &
) 2>&1 | tee -a $LOGDIR/scripts.log &
