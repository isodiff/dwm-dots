#!/bin/sh
dwm_networkmanager () {
    CONNAME=$(nmcli -a | grep 'Wired connection' | awk 'NR==1{print $1}')
    if [ "$CONNAME" = "" ]; then
        CONNAME=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -c 5-)
    fi

    PRIVATE=$(nmcli -a | grep 'inet4 192' | awk '{print $2}')
    PUBLIC=$(curl -s https://ipinfo.io/ip)

    if [ "$IDENTIFIER" = "unicode" ]; then
      export __DWM_BAR_NETWORKMANAGER__="^b#303446^${SEP1} ^c#f2d5cf^󰖩 ${CONNAME} ${SEP2}^d^"
    else
      export __DWM_BAR_NETWORKMANAGER__="$SEP1NET $CONNAME $PRIVATE $PUBLIC$SEP2"
    fi
}

dwm_networkmanager
