#!/usr/bin/env bash

theme_file="$HOME/.config/rofi/themes/style.rasi"
entry_file="$HOME/.config/rofi/themes/entry.rasi"
location="-location 3 -xoffset 0 -yoffset 30"
interface=$(nmcli device status | awk '$2 == "wifi" {print $1; exit}')

refresh_list() {
    nmcli device wifi rescan ifname "$interface"
    sleep 0
}

generate_wifi_list() {
    nmcli -t -f IN-USE,SSID dev wifi list | \
    awk -F ':' '!seen[$2]++ && $2 != ""' | \
    while IFS=':' read -r in_use ssid; do
        prefix=""
        icon=""  # locked
        
        # If the network is in use, set the prefix to show a check mark
        [ "$in_use" == "*" ] && prefix=" "

        # Output the SSID without the security and without extra colons
        echo "${icon} ${prefix}${ssid}"
    done
}

scan_hidden_networks() {
    local mon_iface

    sudo airmon-ng start "$interface" > /dev/null 2>&1
    mon_iface="${interface}mon"
    
    if ! ip link show "$mon_iface" &>/dev/null; then
        notify-send "Error" "Failed to enable monitor mode on interface '$interface'."
        return
    fi
    
    sudo airodump-ng --write /tmp/hidden_networks --output-format csv "$mon_iface" > /dev/null 2>&1 &
    local pid=$!
    sleep 10
    sudo kill "$pid"
    sleep 1
    sudo airmon-ng stop "$mon_iface" > /dev/null 2>&1

    if [[ -f /tmp/hidden_networks-01.csv ]]; then
        hidden_networks=$(awk -F ',' 'NR > 1 && $1 !~ /Station/ && NF > 13 && $14 ~ /^[ \t]*$/ { print "[Hidden] BSSID: " $1 }' /tmp/hidden_networks-01.csv | sort -u)
        echo "$hidden_networks"
        sudo rm -f /tmp/hidden_networks-01.csv
    else
        echo "No hidden networks found."
    fi
}

display_settings_menu() {
    wifi_status=$(nmcli radio wifi)
    wifi_toggle="󰖪 Toggle Wi-Fi: $wifi_status"

    option=$(echo -e "🌐 Change Interface\n➕ Add Hidden Network\n🔑 Saved Networks\n⬅ Back" | rofi -dmenu $location -theme "$theme_file" -p "Settings")

    case "$option" in
        "🌐 Change Interface")
            interfaces=$(nmcli device status | awk '$2 == "wifi" {print $1}')
            selected_iface=$(echo "$interfaces" | rofi -dmenu -theme "$theme_file" -p "Choose Interface")
            [ -n "$selected_iface" ] && interface="$selected_iface" && notify-send "Interface Changed" "Switched to $interface"
            display_settings_menu
            ;;
            
#        "📡 MAC Address")
#            mac=$(nmcli device show "$interface" | grep -i "HWADDR" | awk '{print $2}')
#            echo "$mac" | rofi -dmenu -theme "$theme_file" -p "MAC Address (readonly)"
#            display_settings_menu
#            ;;
#            
#      "📥 DHCP Settings")
#            dhcp_info=$(nmcli -f IP4.ADDRESS,IP4.GATEWAY,IP4.DNS device show "$interface" | grep -E 'IP4.ADDRESS|IP4.GATEWAY|IP4.DNS' | sed 's/[[:space:]]\{2,\}/ /g')
#           if [ -z "$dhcp_info" ]; then
#                notify-send "Error" "No DHCP Info found for the interface $interface"
#                display_settings_menu
#                return
#            fi
#
#            formatted_info=$(echo "$dhcp_info" | awk -F ': ' '{print $1 ": " $2}')
#            echo "$formatted_info" | rofi -theme "$theme_file" -dmenu -p "DHCP Info"
#            display_settings_menu
#            ;;
 
        "➕ Add Hidden Network")
            ssid=$(rofi -dmenu $location -theme "$entry_file" -p "SSID: ")
            [ -z "$ssid" ] && display_settings_menu

            password=$(rofi -dmenu $location -theme "$entry_file" -p "Password: ")

            if nmcli device wifi connect "$ssid" password "$password" hidden yes ifname "$interface"; then
                notify-send "Connected" "Connected to '$ssid'"
            else
                notify-send "Failed" "Failed to connect to '$ssid'"
            fi
            display_settings_menu
            ;;
            
        "🔑 Saved Networks")
            saved_networks=$(nmcli -t -f NAME,TYPE connection show | grep ':802-11-wireless$' | cut -d':' -f1)

            if [ -n "$saved_networks" ]; then
                selected_network=$(echo "$saved_networks" | rofi -dmenu $location -theme "$theme_file" -p "Saved Network")
                if [ -n "$selected_network" ]; then
                    confirm=$(echo -e "Yes\nNo" | rofi -dmenu $location -theme "$theme_file" -p "Delete '$selected_network'?")
                    if [ "$confirm" == "Yes" ]; then
                        nmcli connection delete "$selected_network" && notify-send "Network Removed" "'$selected_network' has been removed"
                    fi
                fi
            else
                notify-send "No Saved Networks" "There are no saved networks to remove."
            fi
            display_settings_menu
            ;;
            
#        "⚙ Network Tools")
#            network_tools_menu
#            display_settings_menu
#            ;;
            
        "$wifi_toggle")
            if [[ "$wifi_status" == "enabled" ]]; then
                nmcli radio wifi off && notify-send "Wi-Fi Disabled"
            else
                nmcli radio wifi on && notify-send "Wi-Fi Enabled"
            fi
            display_settings_menu
            ;;
            
        "⬅ Back") show_main_menu ;;
    esac
}

#network_tools_menu() {
#    choice=$(echo -e "🚀 Speedtest \n🖥 Live Monitor\n📶 Graph Monitor\n⬇️ Curl Download Test\n⬅ Back" | rofi -theme "$theme_file" -dmenu -p "Network Tools")
#
#    case "$choice" in
#        "🚀 Speedtest")
#            	if ! command -v fast &>/dev/null; then
#                	notify-send "fast-cli not installed" "Run: npm install -g fast-cli"
#            	else
#                	fast | rofi -theme "$theme_file" -dmenu -p "Speedtest Result"
#            	fi
#            		network_tools_menu
#            ;;
#        "🖥 Live Monitor")
#           	if ! command -v nload &>/dev/null; then
#    notify-send "nload not installed" "Run: sudo pacman -S nload"
#else
#    # Use rofi to allow selection of the network interface
#    interface=$(echo -e "wlan0\nwlan1\neth0" | rofi -dmenu -theme "$theme_file" -p "Choose an interface:")
#
#    if [ -n "$interface" ]; then
#        # Temporary file to store nload output
#        temp_file=$(mktemp)
#
#        # Start nload in the background and capture its output to a temp file
#        watch -n 1 "nload -t 1 -u M -i $interface | head -n 10" > "$temp_file" &
#        
#        # Display the output in Rofi
#        tail -n 10 -f "$temp_file" | rofi -dmenu -theme "$theme_file" -p "Network Usage ($interface)"
#
#        # Clean up the temporary file when done
#        rm "$temp_file"
#    fi
#fi
#
#            ;;
#        "📊 Graph Monitor (bmon)")
#            	if ! command -v bmon &>/dev/null; then
#                	notify-send "bmon not installed" "Run: sudo pacman -S bmon"
#            	else
#                	xterm -e bmon &
#            	fi
#            ;;
#        "⬇️ Curl Download Test")
#            	curl -o /dev/null http://speedtest.tele2.net/10MB.zip 2>&1 | rofi -theme "$theme_file" -dmenu -p "Curl Result"
#            	network_tools_menu
#            ;;
#        "⬅ Back") return ;;
#    esac
#}


display_available_networks() {
    refresh_list
    local wifi_list hidden_networks

    while true; do
        wifi_list=$(generate_wifi_list)
        menu=$(echo -e "$wifi_list\n🔄 Refresh List\n⬅ Back" | rofi -dmenu $location -theme "$theme_file" -p "Available Networks")

        case "$menu" in
            "⬅ Back" | "") show_main_menu; break ;;
            "🔄 Refresh List") refresh_list; continue ;;
#            "🔍 Scan Hidden Networks")
#                hidden_networks=$(scan_hidden_networks)
#                menu=$(echo -e "$wifi_list\n$hidden_networks\n🔍 Scan Hidden Networks\n🔄 Refresh List\n⬅ Back" | rofi -dmenu -theme "$theme_file" -p "Hidden Networks")
#                case "$menu" in
#                    "⬅ Back" | "") continue ;;
#                   "🔄 Refresh List" | "🔍 Scan Hidden Networks") continue ;;
#                    *) connect_wifi "$menu"; break ;;
#                esac
#                ;;
            *) wifi_settings_menu "$menu"; break ;;
        esac
    done
}


wifi_settings_menu() {
	clean_ssid=$(echo "$1" | sed -E 's/^[^[:alnum:]]+//')
	
	saved=$(nmcli -g NAME connection | grep -Fx "$clean_ssid")
	
	if [[ "$1" == *" "* ]]; then
   		settings=$(echo -e "disconnect\nmodify\nforget\n⬅ Back" | rofi -dmenu $location -theme "$theme_file" -p "$clean_ssid")
   		case "$settings" in
   			"⬅ Back" | "") display_available_networks; break ;;
   		
   		 
   			"disconnect")
   				nmcli connection down "$clean_ssid"
                		notify-send "Disconnected" "Disconnected from '$clean_ssid'" 
                	;;
   			"modify")
   				new_password=$(rofi -dmenu $location -theme "$entry_file" -p "New_Password")
                		if [[ -n "$new_password" ]]; then
                			onfirm=$(echo -e "Yes\nNo" | rofi -dmenu $location -theme "$theme_file" -p "Delete '$clean_ssid'?")
                    				if [ "$confirm" == "Yes" ]; then
                        				nmcli connection modify "$clean_ssid" wifi-sec.key-mgmt wpa-psk wifi-sec.psk "$new_password"
                    					notify-send "Modified" "Password updated for '$clean_ssid'"
                    			
                    					
                    				fi	
                		fi 
                                display_available_networks
                	;;
   			"forget")
   				if [ -n "$clean_ssid" ]; then
                   			 confirm=$(echo -e "Yes\nNo" | rofi -dmenu $location -theme "$theme_file" -p "Delete '$clean_ssid'?")
                    				if [ "$confirm" == "Yes" ]; then
                        				nmcli connection delete "$clean_ssid" && notify-send "Network Removed" "'$clean_ssid' has been removed"
                    				fi
                		fi
                	;;
                	"⬅ Back" | "")
            		display_available_networks
            		;;
   			
   		esac
   		
	elif [[ -n "$saved" ]]; then
    		settings=$(echo -e "connect\nforget\n⬅ Back" | rofi -dmenu $location -theme "$theme_file" -p "Choose an option for '$clean_ssid'")
    		case "$settings" in
        		"connect")
            			connect_wifi 
            		;;
        		"forget")
            			if [ -n "$clean_ssid" ]; then
                			confirm=$(echo -e "Yes\nNo" | rofi $location -dmenu -theme "$theme_file" -p "Delete '$clean_ssid'?")
                			if [ "$confirm" == "Yes" ]; then
                    				nmcli connection delete "$clean_ssid" && notify-send "Network Removed" "'$clean_ssid' has been removed"
                			fi
            			fi
            		;;
        		"⬅ Back" | "")
            		display_available_networks
            		;;
    		esac
	else 
    		settings=$(echo -e "connect\n⬅ Back" | rofi -dmenu $location  -theme "$theme_file" -p "Choose an option")
    		case "$settings" in
        		"connect")
            			connect_wifi 
            		;;
            		"⬅ Back" | "")
            		display_available_networks
            		;;
    	esac
	fi

}
	
	

connect_wifi() {

    saved=$(nmcli -g NAME connection | grep -Fx "$clean_ssid")
    
    if [[ -n "$saved" ]]; then
        nmcli connection up id "$clean_ssid" ifname "$interface" && \
            notify-send "Connected" "Connected to '$clean_ssid'" || \
            notify-send "Failed" "Could not connect to '$clean_ssid'"
    else
        password=""
        if [[ "$menu" == *""* ]]; then
            password=$(rofi -dmenu $location -theme "$entry_file" -p "Password:")
            nmcli device wifi connect "$clean_ssid" password "$password" ifname "$interface" && \
                notify-send "Connected" "Connected to '$clean_ssid'" || \
                notify-send "Failed" "Could not connect to '$clean_ssid'"
        else        
            nmcli device wifi connect "$clean_ssid" password ifname "$interface" && \
                notify-send "Connected" "Connected to '$clean_ssid'" || \
                notify-send "Failed" "Could not connect to '$clean_ssid'"
        fi
    fi
}


show_main_menu() {
    choice=$(echo -e "📶 Available Networks\n⚙ Settings\n🚪 Exit" | rofi -dmenu $location -theme "$theme_file" -p "Wi-Fi Menu")
    case "$choice" in
        "📶 Available Networks") display_available_networks ;;
        "⚙ Settings") display_settings_menu ;;
        "🚪 Exit" | "") exit 0 ;;
    esac
}

# Entry point
show_main_menu
