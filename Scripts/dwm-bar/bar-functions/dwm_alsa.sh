#!/bin/sh

# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: alsa-utils

dwm_alsa () {
	STATUS=$(amixer sget Master | tail -n1 | sed -r "s/.*\[(.*)\]/\1/")
    VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
    printf "%s" "$SEP1"
    if [ "$IDENTIFIER" = "unicode" ]; then
    	if [ "$STATUS" = "off" ]; then
	            printf "^c#e78284^ 󰝟  Muted ^d^"
    	else
    		#removed this line becuase it may get confusing
	        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 10 ]; then
	            printf "^c#e5c890^ 󰕿 %s%%^d^" "$VOL"
	        elif [ "$VOL" -gt 10 ] && [ "$VOL" -le 80 ]; then
	            printf "^c#a6d189^ 󰖀 %s%% ^d^" "$VOL"
	        else
	            printf "^c#ef9f76^ 󰕾 %s%% ^d^" "$VOL"
	        fi
		fi
    else
    	if [ "$STATUS" = "off" ]; then
    		printf "MUTE"
    	else
	        # removed this line because it may get confusing
	        if [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
	            printf "VOL %s%%" "$VOL"
	        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
	            printf "VOL %s%%" "$VOL"
	        else
	            printf "VOL %s%%" "$VOL"
        	fi
        fi
    fi
    printf "%s\n" "$SEP2"
}

dwm_alsa
