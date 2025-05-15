#!/bin/bash

# Check if Wi-Fi is enabled
if nmcli radio wifi | grep -q "enabled"; then
    # Check if connected to a network
    if nmcli -t -f WIFI g | grep -q "enabled" && nmcli -t -f STATE g | grep -q "connected"; then
        echo "  $(nmcli -t -f active,ssid dev wifi | grep yes | cut -d ':' -f2)"  # Wi-Fi Connected (blue)
    
    # Check if it's connecting
    elif nmcli -t -f STATE g | grep -q "connecting"; then
        echo " Connecting..."  # Connecting 
    
    # Wi-Fi is on but not connected
    else
        echo ""  # Wi-Fi On but Not Connected 
    fi
else
    echo "睊"  # Wi-Fi Off
fi
