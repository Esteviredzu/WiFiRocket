#!/bin/bash

get_protection() {
    # Разделяем строку по пробелам и берем последний элемент
    echo "$1" | awk '{print $NF}'
}
connect_WPA2(){
	local bssid=$1
	read -p "Enter password: " password
	nmcli device wifi connect "$bssid" password "$password"
	
}

connect_open(){
	local bssid=$1
	nmcli device wifi connect "$bssid"
	
}

enabled=$(nmcli radio wifi)
if [ "$enabled" = "enabled" ]; then
    echo "Wi-Fi is enabled"
    wifi_list=$(nmcli -f BSSID,SSID,CHAN,RATE,SIGNAL,BARS,SECURITY dev wifi list | tail -n +2)

    while IFS= read -r line; do
        ((counter++))
        echo "$counter: $line"
    done <<< "$wifi_list"
    
    echo "Select network by entering its number:"
    read -p "Number: " selected_number
    selected_line=$(echo "$wifi_list" | sed -n "${selected_number}p")
    selected_bssid=$(echo "$selected_line" | awk '{print $1}')
    echo "Selected network BSSID: $selected_bssid"

    protection=$(get_protection "$selected_line")
    echo "Security: $protection"

    if [ "$protection" = "WPA2" ]; then
    	connect_WPA2 "$selected_bssid"
    else
    	connect_open "$selected_bssid"
    fi
else
    nmcli radio wifi on
    echo "Wi-Fi now is enabled"
fi
