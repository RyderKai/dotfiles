Requirements

Make sure these packages/tools are installed on your system:

    i3-gaps

    polybar

    rofi

    python3

    pulse audio (pactl)

    xrandr

    feh (optional, for wallpapers)

    wal (for colors)

    xterm (or replace with your terminal emulator)

    picom (optional, uncomment if you want compositor effects)

Installation & Usage

    Clone the repo:

git clone https://github.com/RyderKai/i3-setup.git ~/.config/i3

Copy or symlink the polybar configs and scripts:

mkdir -p ~/.config/polybar
cp -r polybar/* ~/.config/polybar/

mkdir -p ~/.config/i3/scripts
cp -r scripts/* ~/.config/i3/scripts/

Make sure the scripts are executable:

chmod +x ~/.config/i3/scripts/i3-alt-tab.py

Configure wallpapers and run wal:

    wal -i ~/Pictures/Wallpapers/your-wallpaper.jpg

    Start or reload i3:

        Log out and back in, or

        Reload config with $mod+Shift+c

    Enjoy your workflow!

Customization Tips

    Change your $mod key in config if Super isn’t your thing.

    Swap out terminal (xterm) for alacritty, kitty, or your fave.

    Adjust workspace app assignments by modifying the assign lines.

    Enable compositor by uncommenting picom lines.

    Add your own scripts or launch apps by adding exec lines.

    Edit Polybar config for colors, modules, and position.
