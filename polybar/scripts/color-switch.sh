#!/bin/bash

## color-switch.sh — with live preview and confirmation

SDIR="$HOME/.config/polybar/scripts"
THEMES=("grey" "darkblue" "teal" "lavender" "orange" "red" "purple")
ICONS=("🌑" "🌑" "🌑" "🌑" "🌑" "🌑" "🌑")

# Build menu
MENU_ITEMS=""
for i in "${!THEMES[@]}"; do
    MENU_ITEMS+="${ICONS[$i]} ${THEMES[$i]}\n"
done

# Show menu
SELECTED=$(echo -e "$MENU_ITEMS" | rofi -dmenu -i -p ' THEMES' -location 3 -xoffset 0 -yoffset 30)


[[ -z "$SELECTED" ]] && exit

# Extract actual theme name
THEME=$(echo "$SELECTED" | awk '{print $2}')

# Apply preview
"$SDIR/colors.sh" "-$THEME"

# Confirm
CONFIRM=$(echo -e "✅ Yes\n❌ No" | rofi -dmenu -i -p "Apply '$THEME'?" -location 3 -xoffset 0 -yoffset 30)

if [[ "$CONFIRM" == "✅ Yes" ]]; then
    notify-send "Polybar Theme" "Switched to $THEME 🎨"
else
    # Optionally revert (or reload previous theme)
    "$SDIR/colors.sh" -grey  # Default fallback theme
    notify-send "Polybar Theme" "Reverted theme change"
fi

