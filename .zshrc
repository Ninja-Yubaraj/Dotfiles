# _   _ _        _        __   __     _                      _ 
#| \ | (_)_ __  (_) __ _  \ \ / /   _| |__   __ _ _ __ __ _ (_)
#|  \| | | '_ \ | |/ _` |  \ V / | | | '_ \ / _` | '__/ _` || |    Yubaraj Sarkar (Ninja-Yubaraj)
#| |\  | | | | || | (_| |   | || |_| | |_) | (_| | | | (_| || |    https://github.com/Ninja-Yubaraj
#|_| \_|_|_| |_|/ |\__,_|___|_| \__,_|_.__/ \__,_|_|  \__,_|/ |    
#             |__/     |_____|                            |__/ 
# My zsh config. The best and the most detailed zsh config ever.

### EXPORT
export TERM="xterm-256color"                      # getting proper colors
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
#export EDITOR="vim"                              # use default editor as vim
#export EDITOR="emacs"                            # use default editor as emacs
#export EDITOR="nvim"                             # use default editor as nvim
#export EDITOR="nano"                             # use default editor as nano 
#export EDITOR=""                                 # use anything you want
#export VISUAL=""                                 # use anything you want
#export ALTERNATE_EDITOR=""                       # if you want to use an alternate editor

### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
#export MANPAGER='/bin/zsh -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
#export MANPAGER="nvim -c 'set ft=man' -"

### Use "tldr" instead of man-pages
## You need to get package:"tldr" for this 
#alias man="tldr"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

### PROMPT
# This is commented out if using any other prompts.
PS1='[\u@\h \W]\$ '

### SETTING THE STARSHIP PROMPT ###
## Get this from website: https://starship.rs/
#eval "$(starship init zsh)"

### POWERLINE-SHELL PROMPT ###
## Get this script from Github: https://github.com/b-ryan/powerline-shell
#function powerline_precmd() {
#    PS1="$(powerline-shell --shell zsh $?)"
#}
#
#function install_powerline_precmd() {
#  for s in "${precmd_functions[@]}"; do
#    if [ "$s" = "powerline_precmd" ]; then
#      return
#    fi
#  done
#  precmd_functions+=(powerline_precmd)
#}
#
#if [ "$TERM" != "linux" ]; then
#    install_powerline_precmd
#fi

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  kitty*|xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### Function extract for common file formats ###
## This function needs several packages, like tar, unzip, p7zip, etc.
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### File transfer using transfer.sh
# Add this to .bashrc or .zshrc or its equivalent
# usage: transfer test.txt
transfer() {
    if [ $# -eq 0 ]; then
        echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>" >&2
        return 1
    fi
    if tty -s; then
        file="$1"
        file_name=$(basename "$file")
        if [ ! -e "$file" ]; then
            echo "$file: No such file or directory" >&2
            return 1
        fi
        if [ -d "$file" ]; then
            file_name="$file_name.zip" ,
            (cd "$file" && zip -r -q - .) | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null,
        else cat "$file" | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null; fi
    else
        file_name=$1
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null
    fi
}

# Neofetch
#clear; neofetch                             # clear screen and show neofetch
#echo                                        # If you need some space, I understand, its ok :)
#neofetch                                    # Standard Neofetch 
#neofetch -L                                 # Neofetch Distro Logo

### RANDOM COLOR SCRIPT ###
# Get this script from DT's GitLab: gitlab.com/dwt1/shell-color-scripts
# Or install it from the Arch User Repository: shell-color-scripts
#colorscript random

### BASH INSULTER (works in zsh though) ###
# Get this script from Github: https://github.com/hkbakke/bash-insulter
#if [ -f /etc/bash.command-not-found ]; then
#    . /etc/bash.command-not-found
#fi

### ALIASES ###

# root privileges
#alias doas="doas --"                        # use doas instead of sudo

# navigation
alias ..='cd ..'                             # Go back 1 directory
alias ...='cd ../..'                         # Go back 2 directories
alias .3='cd ../../..'                       # Go back 3 directories
alias .4='cd ../../../..'                    # Go back 4 directories
alias .5='cd ../../../../..'                 # Go back 5 directories

# Permissions
#alias perm='stat --printf "%a %n \n "'      # perm: Show permission of target in number
#alias 000='chmod 000'                       # ---------- (nobody)
#alias 640='chmod 640'                       # -rw-r----- (user: rw, group: r, other: -)
#alias 644='chmod 644'                       # -rw-r--r-- (user: rw, group: r, other: -)
#alias 755='chmod 755'                       # -rwxr-xr-x (user: rwx, group: rx, other: x)
#alias 775='chmod 775'                       # -rwxrwxr-x (user: rwx, group: rwx, other: rx)
#alias mx='chmod a+x'                        # ---x--x--x (user: --x, group: --x, other: --x)
#alias ux='chmod u+x'                        # ---x------ (user: --x, group: -, other: -)

# Directory Listing aliases
#alias dir='ls -hFx'                         # dir: List directory contents with long format, human readable file sizes, and colorized file types
#alias l.='ls -d .* --color=tty'             # short listing, only hidden files - .*
#alias l='ls -lathF'                         # long, sort by newest to oldest
#alias L='ls -latrhF'                        # long, sort by oldest to newest
#alias la='ls -Al'                           # show hidden files
#alias lc='ls -lcr'                          # sort by change time
#alias lk='ls -lSr'                          # sort by size
#alias lh='ls -lSrh'                         # sort by size human readable
#alias lm='ls -al | more'                    # pipe through 'more'
#alias lo='ls -laSFh'                        # sort by size largest to smallest
#alias lr='ls -lR'                           # recursive ls
#alias lt='ls -ltr'                          # sort by date
#alias lu='ls -lur'                          # sort by access time

# Changing "ls" to "exa"
#alias ls='exa -al --color=always --group-directories-first'                                                 # my preferred listing
#alias la='exa -a --color=always --group-directories-first'                                                  # all files and dirs
#alias ll='exa -l --color=always --group-directories-first'                                                  # long format
#alias lt='exa -aT --color=always --group-directories-first'                                                 # tree listing
#alias l.='exa -a | egrep "^\."'                                                                             # hidden files

# pacman and yay
#alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
#alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
#alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
#alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
#alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
#alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
#alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

# apt and apt-get
# I recommend using the "apt" package manager instead of "apt-get"
#alias aptupdate='apt update -y'                  # update all packages (apt)
#alias aptupgrade='apt upgrade -y'                # upgrade all packages (apt)
#alias aptfupgrade='apt full-upgrade -y'          # upgrade all packages (apt)
#alias aptautoremove='apt autoremove -y'          # remove unused packages (apt)
#alias aptclean='apt clean -y'                    # remove downloaded package files (apt)
#alias apt-get='apt'                              # If you can't get the habit of using "apt". Though it's still better than "apt-get". Still some commands will be different.
#alias aptgupdate='apt-get update -y'             # update all packages (apt-get)
#alias aptgupgrade='apt-get upgrade -y'           # upgrade all packages (apt-get)
#alias aptgdupgrade='apt-get dist-upgrade -y'     # upgrade all packages (apt-get)
#alias apt='apt-get'                              # apt-get alias. Use "apt" instead. Use this if you don't have any other options.

# get fastest mirrors
#alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"             # fastest mirrors
#alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"         # fastest mirrors (delay)
#alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"         # fastest mirrors (score)
#alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"           # fastest mirrors (age)

# Colorize grep output (good for log files)
alias grep='grep --color=auto'                    # show differences in color
alias egrep='egrep --color=auto'                  # show differences in color
alias fgrep='fgrep --color=auto'                  # show differences in color

# confirm before overwriting something
alias cp="cp -i"                                  # confirm before overwriting
alias mv='mv -i'                                  # confirm before overwriting
alias rm='rm -i'                                  # confirm before deleting

# trash things instead of deleting them
#alias rmtrash='rm -rf ~/.local/share/Trash/*'    # remove all files in trash

# shred (uncomment only one of them)
#alias shred='shred -u -n 3'                      # securely erase files
#alias shred='shred -uzn3'                        # Elliot's favorite (Mr.Robot)
alias shred='shred -uzvn3'                        # Ninja's favorite
#alias shred='shred -uzvn10'                      # uncomment this if you're on FBI's watchlist
#alias shred='shred -uzvn20'                      # just whyyy?????
#alias shred='shred -uzvn50'                      # plz stop!!!
#alias shred='shred -uzvn100'                     # there a special place in hell for you my friend

# adding flags to make it more readable
alias df='df -h'                                  # human-readable sizes
alias free='free -m'                              # show sizes in MB

# get top process eating cpu and memory
alias psa="ps auxf"                                        # show all processes
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"   # show all processes eating memory
alias psmem='ps auxf | sort -nr -k 4'                      # show all processes eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10'         # show top 10 processes eating memory
alias pscpu='ps auxf | sort -nr -k 3'                      # show all processes eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'         # show top 10 processes eating cpu

# History
alias clearbashhistory='cat /dev/null > ~/.bash_history && history -c && exit'                                # clearbashhistory: Clear bash history
alias clearzshhistory='cat /dev/null > ~/.zsh_history && history -c && exit'                                  # clearzshhistory: Clear zsh history
alias clearhistory='clearbashhistory && clearzshhistory'                                                      # clearhistory:   Clear both bash and zsh history
alias historysize='history | wc -l'                                                                           # historysize:    Show the number of history entries
alias historysearch='history | grep -i'                                                                       # historysearch:  Search the history
alias historysearchclear='history | grep -i | xargs -I {} history -s {}'                                      # historysearchclear: Search and clear the history
alias historysearchclearall='history | grep -i | xargs -I {} history -c {}'                                   # historysearchclearall: Search and clear the history
alias historysearchclearallbut='history | grep -i | xargs -I {} history -c {} | xargs -I {} history -s {}'    # historysearchclearallbut: Search and clear the history

# Networking
alias netCons='lsof -i'                                                             # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/sbin/lsof -i -P'                                             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'                                   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'                                   # lsockT:       Display only open TCP sockets
alias ipInfo0='ifconfig getpacket en0'                                              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ifconfig getpacket en1'                                              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'                                        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                                                  # showBlocked:  All ipfw rules inc/ blocked IPs
alias publicip='echo "Current Public IP address is:" && curl ifconfig.me && echo'   # publicip:     Get Public IP address

# git
#alias addup='git add -u'                                                           # addup:        Add all untracked files
#alias addall='git add .'                                                           # addall:       Add all files
#alias branch='git branch'                                                          # branch:       List all branches
#alias checkout='git checkout'                                                      # checkout:     Checkout a branch 
#alias clone='git clone'                                                            # clone:        Clone a repository
#alias commit='git commit -m'                                                       # commit:       Record changes to the repository
#alias fetch='git fetch'                                                            # fetch:        Download remote objects and refs
#alias pull='git pull origin'                                                       # pull:         Fetch and merge with remote changes
#alias push='git push origin'                                                       # push:         Uploads local objects and refs
#alias stat='git status'    # 'status' is protected name so using 'stat' instead    # stat:         Show the status of the current git repo
#alias tag='git tag'                                                                # tag:          Create a tag object signed by you
#alias newtag='git tag -a'                                                          # newtag:       Create a new tag object

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"                                                    # jctl:         Show errors from journalctl

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"               # gpg-check:    Verify a signature
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"      # gpg-retrieve: Retrieve a key

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "                      # yta-aac:      Download audio in aac format
alias yta-best="youtube-dl --extract-audio --audio-format best "                    # yta-best:     Download audio in best format
alias yta-flac="youtube-dl --extract-audio --audio-format flac "                    # yta-flac:     Download audio in flac format
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "                      # yta-m4a:      Download audio in m4a format
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "                      # yta-mp3:      Download audio in mp3 format
alias yta-opus="youtube-dl --extract-audio --audio-format opus "                    # yta-opus:     Download audio in opus format
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "                # yta-vorbis:   Download audio in vorbis format
alias yta-wav="youtube-dl --extract-audio --audio-format wav "                      # yta-wav:      Download audio in wav format
alias ytv-best="youtube-dl -f bestvideo+bestaudio "                                 # ytv-best:     Download video in best format

# xclip
alias xcopy="xclip -selection clipboard"                                            # xcopy:        Copy to clipboard
alias xpaste="xclip -selection clipboard -o"                                        # xpaste:       Paste from clipboard

# termbin.com
# usage: cat .bashrc | tbin 
alias tbin="nc termbin.com 9999"                                                    # tbin:         Pipe to termbin.com
alias tbinc='nc termbin.com 9999 | xcopy ; echo "Link copied to the clipboard!!!"'  # tbinc:        Pipe to termbin.com and copy to clipboard

# transfer.sh
# usage: tsh .bashrc
alias tsh='transfer'                                                                # tsh:          Transfer files to transfer.sh

# ani-cli
# Get this script from Github: https://github.com/pystardust/ani-cli or AUR
alias ani='ani-cli'                                                                 # ani:          Ani-cli
alias anid='ani-cli -d'                                                             # anid:         Download anime
alias anih='ani-cli -H'                                                             # anih:         Resume watching anime
alias anib='ani-cli -q "best"'                                                      # anib:         Watch anime with best quality
alias aniw='ani-cli -q "worst"'                                                     # aniw:         Watch anime with worst quality
alias anidb='ani-cli -d -q "best"'                                                  # anidb:        Download best quality
alias anidw='ani-cli -d -q "worst"'                                                 # anidw:        Download worst quality

# wttr.in
# Github: https://github.com/chubin/wttr.in
alias wttr='curl wttr.in'                                                           # wttr:         Get weather from wttr.in
alias wttr-moon='curl wttr.in/moon'                                                 # wttr-moon:    Get Moon phase from wttr.in

# switch between shells
# I do not recommend switching default SHELL from bash.
#alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"                 # tobash:       Switch to bash
#alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"                   # tozsh:        Switch to zsh
#alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"                 # tofish:       Switch to fish

# the terminal rickroll
# I do not recommend switching this ON in any case. 
#alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'          # rr:           Terminal Rickroll

# wc
alias wcl='wc -l'                                                                   # wcl:           Count lines of code
alias wcw='wc -w'                                                                   # wcw:           Count words of code
alias wcc='wc -c'                                                                   # wcc:           Count characters of code

# MISC
#alias nc='ncat'                                                                    # nc:           use nc instead of ncat, for our termux users. Don't worry I am here for you.
#alias c='clear'                                                                    # c:            clear the terminal.
#alias vim='nvim'
