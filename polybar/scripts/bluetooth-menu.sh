#!/usr/bin/env bash
#
# Define the theme file
theme_file="$HOME/.config/rofi/themes/style.rasi"

# Constants
goback="󰁍 Back"
settings="󰓕 Settings"

# Rofi command with dynamic theme file
rofi_command="rofi -dmenu -location 3 -xoffset 0 -yoffset 30 -theme $theme_file -p"

# Icons
power_on_icon="󰂯 Power: on"
power_off_icon="󰂲 Power: off"
scan_on_icon="󰍜 Scan: on"
scan_off_icon="󰍛 Scan: off"
pairable_on_icon="󰖾 Pairable: on"
pairable_off_icon="󰖽 Pairable: off"
discoverable_on_icon="󰗚 Discoverable: on"
discoverable_off_icon="󰗛 Discoverable: off"
connected_icon="󰂱 Connected: yes"
disconnected_icon="󰂲 Connected: no"
trust_yes_icon="󰄲 Trusted: yes"
trust_no_icon="󰄳 Trusted: no"
paired_yes_icon="󰂐 Paired: yes"
paired_no_icon="󰂑 Paired: no"

# Functions for Bluetooth State
power_on() { bluetoothctl show | grep -q "Powered: yes"; }
pairable_on() { bluetoothctl show | grep -q "Pairable: yes" && echo "$pairable_on_icon" || echo "$pairable_off_icon"; }
discoverable_on() { bluetoothctl show | grep -q "Discoverable: yes" && echo "$discoverable_on_icon" || echo "$discoverable_off_icon"; }
scan_on() { bluetoothctl show | grep -q "Discovering: yes" && echo "$scan_on_icon" || echo "$scan_off_icon"; }

# Toggle States
toggle_power() { power_on && bluetoothctl power off || bluetoothctl power on; show_menu; }
toggle_scan() { bluetoothctl show | grep -q "Discovering: yes" && bluetoothctl scan off || bluetoothctl scan on; settings_menu; }
toggle_pairable() { bluetoothctl show | grep -q "Pairable: yes" && bluetoothctl pairable off || bluetoothctl pairable on; settings_menu; }
toggle_discoverable() { bluetoothctl show | grep -q "Discoverable: yes" && bluetoothctl discoverable off || bluetoothctl discoverable on; settings_menu; }

# Device Status
device_connected() { bluetoothctl info "$1" | grep -q "Connected: yes"; }
device_paired() { bluetoothctl info "$1" | grep -q "Paired: yes" && echo "$paired_yes_icon" || echo "$paired_no_icon"; }
device_trusted() { bluetoothctl info "$1" | grep -q "Trusted: yes" && echo "$trust_yes_icon" || echo "$trust_no_icon"; }

# Device Actions
toggle_connection() { device_connected "$1" && bluetoothctl disconnect "$1" || bluetoothctl connect "$1"; device_menu "$device"; }
toggle_paired() { device_paired "$1" && bluetoothctl remove "$1" || bluetoothctl pair "$1"; device_menu "$device"; }
toggle_trust() { device_trusted "$1" && bluetoothctl untrust "$1" || bluetoothctl trust "$1"; device_menu "$device"; }
rename_device() {
    new_name=$(echo "" | rofi -dmenu -p "󰻞 New name")
    [ -n "$new_name" ] && bluetoothctl system-alias "$1" "$new_name"
    device_menu "$device"
}

remove_device() {
    bluetoothctl remove "$1"
    show_menu
}

# Device Menu
device_menu() {
    device=$1
    device_name=$(echo "$device" | cut -d ' ' -f 3-)
    mac=$(echo "$device" | cut -d ' ' -f 2)

    connected_status=$(device_connected "$mac" && echo "$connected_icon" || echo "$disconnected_icon")
    paired_status=$(device_paired "$mac")
    trust_status=$(device_trusted "$mac")

    options="$connected_status\n$paired_status\n$trust_status\n󰯈 Rename\n󰗧 Remove\n$goback"
    chosen=$(echo -e "$options" | $rofi_command "$device_name")

    case "$chosen" in
        "$connected_status") toggle_connection "$mac" ;;
        "$paired_status") toggle_paired "$mac" ;;
        "$trust_status") toggle_trust "$mac" ;;
        "󰯈 Rename") rename_device "$mac" ;;
        "󰗧 Remove") remove_device "$mac" ;;
        "$goback") show_menu ;;
        *) echo "No option chosen." ;;
    esac
}

# Settings Menu
settings_menu() {
    power_status=$(power_on && echo "$power_on_icon" || echo "$power_off_icon")
    scan_status=$(scan_on)
    pairable_status=$(pairable_on)
    discoverable_status=$(discoverable_on)

    options="$power_status\n$scan_status\n$pairable_status\n$discoverable_status\n$goback"
    chosen=$(echo -e "$options" | $rofi_command "󰓕 Settings")

    case "$chosen" in
        "$power_status") toggle_power ;;
        "$scan_status") toggle_scan ;;
        "$pairable_status") toggle_pairable ;;
        "$discoverable_status") toggle_discoverable ;;
	
        "$goback") show_menu ;;
        Exit) exit 0 ;;
        *) echo "No option chosen." ;;
    esac
}

# Main Menu
show_menu() {
    if power_on; then
        devices_output=$(bluetoothctl devices)
        device_lines=$(echo "$devices_output" | grep '^Device')
        device_names=$(echo "$device_lines" | cut -d ' ' -f 3-)
        device_map=$(echo "$device_lines" | sed 's/^Device //')

        options=$(echo -e "$device_names\n$settings\nExit")
        chosen=$(echo -e "$options" | $rofi_command "󰂯 Bluetooth")

        if [[ "$chosen" == "$settings" ]]; then
            settings_menu
        elif [[ "$chosen" == "Exit" ]]; then
            exit 0
        elif [[ "$chosen" != "$divider" && -n "$chosen" ]]; then
            device_line=$(echo "$device_map" | grep " $chosen\$")
            if [[ -n "$device_line" ]]; then
                device_menu "Device $device_line"
            fi
        fi
    else
        options="$power_off_icon\nExit"
        chosen=$(echo -e "$options" | $rofi_command "󰂯 Bluetooth")

        case "$chosen" in
            "$power_off_icon") toggle_power ;;
            Exit) exit 0 ;;
        esac
    fi
}
# Script entry point
case "$1" in
    --status)
        bluetoothctl show
        ;;
    *)
        show_menu
        ;;
esac