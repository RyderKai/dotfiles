#!/bin/bash

wifi_status=$(nmcli -t -f WIFI g)

if [ "$wifi_status" = "enabled" ]; then
	nmcli radio wifi off && sleep 1 && notify-send "󰖪 Wi-Fi Disabled"
else
	nmcli radio wifi on && sleep 1 && notify-send "󰖩 Wi-Fi Enabled"
fi
