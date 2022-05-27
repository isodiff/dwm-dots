#!/bin/bash
sleep 20
kitty -1 -T=WELCOME bash /home/twfl/Scripts/welcomelol.sh
kitty -1 -T=WELCOME --wait-for-single-instance-window-close -d=/home/twfl/ zsh
