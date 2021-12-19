#!/bin/bash
#
# NOTE: run this script with sudo or it will not work!!!

sudo mkdir -p /etc/pacman.d/hooks
sudo rm /etc/pacman.d/hooks/recompile-xmonad.hook
sudo rm /etc/pacman.d/hooks/recompile-xmonadh.hook
sudo ln -s ~/.xmonad/pacman-hooks/recompile-xmonad.hook /etc/pacman.d/hooks/recompile-xmonad.hook
sudo ln -s ~/.xmonad/pacman-hooks/recompile-xmonadh.hook /etc/pacman.d/hooks/recompile-xmonadh.hook