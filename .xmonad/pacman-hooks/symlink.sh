#!/bin/bash
#
# NOTE: Run this script with sudo or it will not work!!!
# NOTE: You have to run this script as root everytime you change something in the scripts!

mkdir -p /etc/pacman.d/hooks

ln -fs $PWD/recompile-xmonad.hook /etc/pacman.d/hooks/recompile-xmonad.hook
ln -fs $PWD/recompile-xmonadh.hook /etc/pacman.d/hooks/recompile-xmonadh.hook
