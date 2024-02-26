#!/bin/bash

# Function to extract the security protection type from the line
get_protection() {
    # Split the line by spaces and take the last element
    echo "$1" | awk '{print $NF}'
}

# Function to connect to a WPA2 protected network
connect_WPA2(){
    local bssid=$1
    read -p "Enter password: " password
    nmcli device wifi connect "$bssid" password "$password"
}

# Function to connect to an open network
connect_open(){
    local bssid=$1
    nmcli device wifi connect "$bssid"
}

# Check if Wi-Fi is enabled
enabled=$(nmcli radio wifi)
if [ "$enabled" = "enabled" ]; then
    echo "Wi-Fi is enabled"
    # Get the list of available Wi-Fi networks
    wifi_list=$(nmcli -f BSSID,SSID,CHAN,RATE,SIGNAL,BARS,SECURITY dev wifi list | tail -n +2)

    # Display the Wi-Fi networks
    while IFS= read -r line; do
        ((counter++))
        echo "$counter: $line"
    done <<< "$wifi_list"
    
    # Prompt user to select a network
    echo "Select a network by entering its number:"
    read -p "Number: " selected_number
    selected_line=$(echo "$wifi_list" | sed -n "${selected_number}p")
    selected_bssid=$(echo "$selected_line" | awk '{print $1}')
    echo "Selected network BSSID: $selected_bssid"

    # Determine the security type of the selected network
    protection=$(get_protection "$selected_line")
    echo "Security: $protection"

    # Connect to the selected network based on its security type
    if [ "$protection" = "WPA2" ]; then
        connect_WPA2 "$selected_bssid"
    else
        connect_open "$selected_bssid"
    fi
else
    # If Wi-Fi is not enabled, turn it on
    nmcli radio wifi on
    echo "Wi-Fi is now enabled"
fi
