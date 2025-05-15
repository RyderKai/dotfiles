#!/bin/sh

# Bluetooth is powered on
if bluetoothctl show | grep -q "Powered: yes"; then
    # Check if Bluetooth is connected (there's an active device connection)
    if bluetoothctl info | grep -q "Connected: yes"; then
        device_name=$(bluetoothctl info | grep "Name" | head -n 1 | cut -d ' ' -f 2-)
        echo " $device_name"  # Bluetooth Connected (blue)
    
    # Check if Bluetooth is scanning for devices
    elif bluetoothctl show | grep -q "Discovering: yes"; then
        echo ""  # Searching (orange)
    
    # Bluetooth is on but not connected
    else
        echo ""  # Bluetooth On but Not Connected (grey)
    fi

# Bluetooth is powered off
else
    echo ""  # Bluetooth Off (dark grey)
fi

