#!/bin/bash

# Start audio servers
(
pipewire &
pipewire-pulse &
echo -e "$(date) started the audio server"
) 2>&1 | tee -a scripts.log


# Set a wallaper
(
bash /home/twfl/Scripts/wallpaper-switcher.sh &
echo -e "$(date) started the wallapper script"
) 2>&1 | tee -a scripts.log

# Dwm bar xsetroot
(
bash /home/twfl/Scripts/bar/dwm_bar.sh &
echo -e "$(date) started the dwm_bar script"
) 2>&1 | tee -a scripts.log

# Open the kitty terminal
(
kitty -1 -T="Hey, Hi, Hello" --wait-for-single-instance-window-close -d=/home/twfl/ bash /home/twfl/Scripts/welcomelol.sh &
echo -e "$(date) started the kitty terminal window"
) 2>&1 | tee -a scripts.log

# Open Browser
ungoogled-chromium &
(
echo -e "$(date) started the browser"
) 2>&1 | tee -a scripts.log
