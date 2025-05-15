#!/bin/bash

## colors.sh
## Switches Polybar color themes
TDIR="$HOME/.config/rofi/themes"
PDIR="$HOME/.config/polybar"
LAUNCH="polybar-msg cmd restart"

echo "Changing theme: $1" # Debug output

if [[ $1 = "-grey" ]]; then
    # Replacing colors for grey theme
    echo "Applying grey theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #2e2c2d/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #3a3839/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #474445/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #534f50/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #605b5c/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #6d6768/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #7a7374/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #878080/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #1b1b1b/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #d3d3d3/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #2e2c2d/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #63484b/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused = #d9d9d9/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #b0b0b0/g' $PDIR/config.ini
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #b3b3b3/g' $PDIR/config.ini
    sed -i \
  -e 's/^\(\s*background:\s*\)#\w\+;/\1#1b1b1b;/' \
  -e 's/^\(\s*background-alt:\s*\)#\w\+;/\1#2e2c2d;/' \
  -e 's/^\(\s*foreground:\s*\)#\w\+;/\1#d3d3d3;/' \
  -e 's/^\(\s*border:\s*\)#\w\+;/\1#3a3839;/' \
  -e 's/^\(\s*active:\s*\)#\w\+;/\1#63484b;/' \
  -e 's/^\(\s*urgent:\s*\)#\w\+;/\1#e06c75;/' \
  $TDIR/style.rasi

    
    $LAUNCH &
    
elif [[ $1 = "-darkblue" ]]; then
    # Replacing colors for darkblue theme
    echo "Applying darkblue theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #00284d/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #003566/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #004280/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #004f99/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #005cb3/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #0069cc/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #0077e6/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #0084ff/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #0a1218/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #d1d9db/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #1b2b35/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #3e4a59/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused = #b3daff/g' $PDIR/config.ini
    sed -i -e 's/unfocused = .*/unfocused = #339cff/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #80c1ff/g' $PDIR/config.ini 
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #99ceff/g' $PDIR/config.ini  
    sed -i \
  -e 's/^\(\s*background:\s*\)#\w\+;/\1#0b0e14;/' \
  -e 's/^\(\s*background-alt:\s*\)#\w\+;/\1#121820;/' \
  -e 's/^\(\s*foreground:\s*\)#\w\+;/\1#cbd6e2;/' \
  -e 's/^\(\s*border:\s*\)#\w\+;/\1#1f2a38;/' \
  -e 's/^\(\s*active:\s*\)#\w\+;/\1#3b7dd8;/' \
  -e 's/^\(\s*urgent:\s*\)#\w\+;/\1#d74d4d;/' \
  $TDIR/style.rasi

    $LAUNCH &    

elif [[ $1 = "-orange" ]]; then
    # Replacing colors for orange theme
    echo "Applying orange theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #3e2c1c/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #4b3b2e/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #5a4a37/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #6b5b46/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #7a6b56/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #8b7c66/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #9b8d76/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #a79b86/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #2b1a12/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #d8d3c4/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #4b3b2e/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #ba5936/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused =  #ece5df/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #f0e1c7/g' $PDIR/config.ini
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #f0f0c7/g' $PDIR/config.ini
    sed -i \
  -e 's/^\(\s*background:\s*\)#\w\+;/\1#1f140e;/' \
  -e 's/^\(\s*background-alt:\s*\)#\w\+;/\1#2a1c12;/' \
  -e 's/^\(\s*foreground:\s*\)#\w\+;/\1#ffcc99;/' \
  -e 's/^\(\s*border:\s*\)#\w\+;/\1#b35309;/' \
  -e 's/^\(\s*active:\s*\)#\w\+;/\1#e67e22;/' \
  -e 's/^\(\s*urgent:\s*\)#\w\+;/\1#ff5e3a;/' \
  $TDIR/style.rasi

    $LAUNCH &

elif [[ $1 = "-red" ]]; then
    # Replacing colors for red theme
    echo "Applying red theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #3b1e23/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #4a2328/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #5a2b2f/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #6a3336/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #7b3a3e/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #8b4447/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #9b4f51/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #aa5a55/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #2d1115/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #f1d0d5/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #4a2328/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #b8213d/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused = #efdcde/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #ffd3d7/g' $PDIR/config.ini
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #ffe6e8/g' $PDIR/config.ini
    sed -i \
  -e 's/^\(\s*background:\s*\)#\w\+;/\1#1a0b0b;/' \
  -e 's/^\(\s*background-alt:\s*\)#\w\+;/\1#2d0e0e;/' \
  -e 's/^\(\s*foreground:\s*\)#\w\+;/\1#ffd6d6;/' \
  -e 's/^\(\s*border:\s*\)#\w\+;/\1#ab2a2a;/' \
  -e 's/^\(\s*active:\s*\)#\w\+;/\1#e33434;/' \
  -e 's/^\(\s*urgent:\s*\)#\w\+;/\1#ff3b3b;/' \
  $TDIR/style.rasi

    $LAUNCH &

elif [[ $1 = "-purple" ]]; then
    # Replacing colors for purple theme
    echo "Applying purple theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #0d001a/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #1a0033/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #26004d/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #330066/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #400080/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #5900b3/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #6600cc/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #7300e6/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #2d2b42/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #d0cfe5/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #3b3a5b/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #535170/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused = #e0e0eb/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #c0c1d8/g' $PDIR/config.ini
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #dfe0ec/g' $PDIR/config.ini
    $LAUNCH &

elif [[ $1 = "-teal" ]]; then
    # Replacing colors for deep teal theme
    echo "Applying deep teal theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #1f2a29/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #2a3c3a/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #345b59/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #4a736f/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #5e8d87/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #71a19f/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #84b6b0/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #90bbb5/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #0d1715/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #d2e2e0/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #2a3c3a/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #345b59/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused = #f0f5f3/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #d1e1da/g' $PDIR/config.ini
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #e0ebe6/g' $PDIR/config.ini
    sed -i \
  -e 's/^\(\s*background:\s*\)#\w\+;/\1#0f1d1d;/' \
  -e 's/^\(\s*background-alt:\s*\)#\w\+;/\1#143333;/' \
  -e 's/^\(\s*foreground:\s*\)#\w\+;/\1#ccf2f2;/' \
  -e 's/^\(\s*border:\s*\)#\w\+;/\1#1abc9c;/' \
  -e 's/^\(\s*active:\s*\)#\w\+;/\1#16a085;/' \
  -e 's/^\(\s*urgent:\s*\)#\w\+;/\1#ff6b6b;/' \
  $TDIR/style.rasi

    $LAUNCH &

elif [[ $1 = "-lavender" ]]; then
    # Replacing colors for muted lavender theme
    echo "Applying muted lavender theme..."  # Debug output
    sed -i -e 's/shade1 = .*/shade1 = #2e1d3d/g' $PDIR/config.ini
    sed -i -e 's/shade2 = .*/shade2 = #3a2a54/g' $PDIR/config.ini
    sed -i -e 's/shade3 = .*/shade3 = #4a376a/g' $PDIR/config.ini
    sed -i -e 's/shade4 = .*/shade4 = #5b467f/g' $PDIR/config.ini
    sed -i -e 's/shade5 = .*/shade5 = #6f578e/g' $PDIR/config.ini
    sed -i -e 's/shade6 = .*/shade6 = #816a9d/g' $PDIR/config.ini
    sed -i -e 's/shade7 = .*/shade7 = #95839c/g' $PDIR/config.ini
    sed -i -e 's/shade8 = .*/shade8 = #a68da3/g' $PDIR/config.ini
    sed -i -e 's/bground = .*/bground = #20112a/g' $PDIR/config.ini
    sed -i -e 's/fground = .*/fground = #e0d4e3/g' $PDIR/config.ini
    sed -i -e 's/borderbg = .*/borderbg = #3a2a54/g' $PDIR/config.ini
    sed -i -e 's/accent = .*/accent = #4a376a/g' $PDIR/config.ini
    sed -i -e 's/unfocused = .*/unfocused = #5b467f/g' $PDIR/config.ini
    sed -i -e 's/focused = .*/focused = #c0b8c7/g' $PDIR/config.ini
    sed -i -e 's/modulefg = .*/modulefg = #c1b8c7/g' $PDIR/config.ini
    sed -i -e 's/modulefg-alt = .*/modulefg-alt = #dad4dd/g' $PDIR/config.ini
    sed -i \
  -e 's/^\(\s*background:\s*\)#\w\+;/\1#2b2533;/' \
  -e 's/^\(\s*background-alt:\s*\)#\w\+;/\1#3d3561;/' \
  -e 's/^\(\s*foreground:\s*\)#\w\+;/\1#e6d9f3;/' \
  -e 's/^\(\s*border:\s*\)#\w\+;/\1#b497d6;/' \
  -e 's/^\(\s*active:\s*\)#\w\+;/\1#a179c9;/' \
  -e 's/^\(\s*urgent:\s*\)#\w\+;/\1#d85f8f;/' \
  $TDIR/style.rasi

    $LAUNCH &



else
    	echo "Available options:"
	echo "-grey"
	echo "-darkblue"
	echo "-teal"
	echo "-lavender"
	echo "-orange"  
	echo "-red"     
	echo "-purple"  

fi
