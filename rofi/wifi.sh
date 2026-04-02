#!/usr/bin/env bash

# Rofi wifi menu using nmcli

ROFI="rofi -dmenu -config ~/.config/rofi/config.rasi -p "

notify() {
    notify-send "wifi" "$1" 2>/dev/null || true
}

# Scan and list networks
scan() {
    nmcli --fields SSID,SECURITY,SIGNAL device wifi list --rescan yes 2>/dev/null \
        | tail -n +2 \
        | awk '{
            ssid=$1
            for(i=2;i<=NF-2;i++) ssid=ssid" "$i
            sec=$(NF-1)
            sig=$NF
            # skip empty SSIDs
            if (ssid == "--") next
            printf "%-40s  %s%%  %s\n", ssid, sig, (sec=="--" ? "open" : "secure")
          }' \
        | sort -t'%' -k1 -rn \
        | awk '!seen[$1]++'
}

# Get saved connections
saved() {
    nmcli --fields NAME,TYPE connection show \
        | awk '/wifi/{print $1}'
}

ACTIVE_SSID=$(nmcli -t -f ACTIVE,SSID device wifi | awk -F: '/^yes/{print $2}')
ACTIVE_DEV=$(nmcli -t -f DEVICE,TYPE,STATE device | awk -F: '/wifi.*connected/{print $1}')

MENU_ITEMS=$(scan)
CHOICE=$(echo -e "disconnect\n---\n$MENU_ITEMS" | $ROFI "  wifi ")

[[ -z "$CHOICE" ]] && exit 0

# Strip signal/security suffix — grab just the SSID (first field, trimmed)
SSID=$(echo "$CHOICE" | awk '{$NF=""; $(NF-1)=""; gsub(/[[:space:]]+$/, ""); print}' | xargs)

if [[ "$CHOICE" == "disconnect" ]]; then
    nmcli device disconnect "$ACTIVE_DEV" && notify "disconnected"
    exit 0
fi

if [[ "$CHOICE" == "---" ]]; then
    exit 0
fi

# Check if already connected
if [[ "$SSID" == "$ACTIVE_SSID" ]]; then
    notify "already connected to $SSID"
    exit 0
fi

# Try saved connection first
if nmcli connection show "$SSID" &>/dev/null; then
    nmcli connection up "$SSID" && notify "connected to $SSID" || notify "failed to connect to $SSID"
    exit 0
fi

# New network — prompt for password if secured
if echo "$CHOICE" | grep -q "secure"; then
    PASSWORD=$(echo "" | $ROFI "  password " "-password")
    [[ -z "$PASSWORD" ]] && exit 0
    nmcli device wifi connect "$SSID" password "$PASSWORD" && notify "connected to $SSID" || notify "failed — wrong password?"
else
    nmcli device wifi connect "$SSID" && notify "connected to $SSID" || notify "failed to connect to $SSID"
fi
