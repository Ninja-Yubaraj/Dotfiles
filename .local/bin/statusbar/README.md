## Statusbar Binaries*
Some standard minimalistic scripts, mostly text based, with a few icons patched with [Nerd Fonts](https://www.nerdfonts.com/) for ricing those Status bars.

## List of supported Status bars:

- i3bar : Standard, looks ok, can customise status message using i3status, i3blocks, or a custom script.

- lemonbar: i3bar but a bit further. It's pretty much just a style-able bar that will display the output of a terminal command or script. You have to write your own workspaces script. Tricky and somewhat limited, but looks nice.

- polybar: Style-able bar, configured with a config file. Based kind of around widgets that can be grouped at the left or right, or the centre of the panel. Looks pretty nice and is generally the best choice if you want something on the flashy side (for a bar).

- xfce4-panel: Panel from Xfce. Simple and really quick to set up. Has an i3-workspaces widget you can install. Not particularly theme-able, but perfectly good-looking. Note that the i3-workspaces widget doesn't like colours or transparency. The background behind it is slightly brighter than the one you pick for the bar, and it just completely dis-obeys transparency or a background image.

- tint2: tint2 is a simple panel/taskbar made for modern X window managers. It was specifically made for Openbox

- xmobar: xmobar is a minimalistic, mostly text based, status bar. It was originally designed and implemented by Andrea Rossato to work with xmonad, but it's actually usable with any window-manager.

- dzen2: a general purpose messaging, notification and menuing program for X11. It was designed to be scriptable in any language and integrate well with window managers like dwm, wmii and xmonad though it will work with any window manager.

## List of supported Status generators:

- i3status: Basic vanilla i3 status

- i3blocks: status line handling clicks and signals for user defined scripts.

- i3pystatus: highly configurable python generated status with user created modules

- py3status: far less configurable and therefore less daunting python generated status with user created modules. It adds external modules to the i3status configuration file that are configured identically to i3status.

- bumblebee-status: very easy to use drop in replacement for i3status with themes and click event handling.

---
*: I normally address executables files in linux as binaries. Old habit.
