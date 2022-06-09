#!/bin/bash
#
# NOTE: Run this script with sudo or it will not work!!!
# NOTE: You have to run this script as root everytime you change something in the scripts!

mkdir -p /etc/pacman.d/hooks
rm /etc/pacman.d/hooks/recompile-xmonad.hook
rm /etc/pacman.d/hooks/recompile-xmonadh.hook
echo "If running this script first time, ignore the error message about missing file"

#ln -s ~/.xmonad/pacman-hooks/recompile-xmonad.hook /etc/pacman.d/hooks/recompile-xmonad.hook
#ln -s ~/.xmonad/pacman-hooks/recompile-xmonadh.hook /etc/pacman.d/hooks/recompile-xmonadh.hook
#I tried to use the above two lines, but it didn't work. Error: when I tried to run the script as root, it tried to create a symlink to a file that doesn't exist in the home directory.

cp recompile-xmonad.hook /etc/pacman.d/hooks/recompile-xmonad.hook
cp recompile-xmonadh.hook /etc/pacman.d/hooks/recompile-xmonadh.hook
# This method works too, but we need to run the script every time we change something in the scripts.