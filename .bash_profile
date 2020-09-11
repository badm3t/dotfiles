#
# ~/.bash_profile
#
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/go/bin"
PATH="$PATH:$HOME/bin"
export SHELL=/bin/bash

alias ls="ls --classify --tabsize=0 --group-directories-first --color=auto --human-readable --literal --show-control-chars"
alias l="ls -lF --color=auto" # all files, in long format
alias la="ls -lA" # all files inc dotfiles, in long format
alias lsd='ls -lF --color=auto | grep "^d"' # only directories
alias ta='command todo2 -A' # show all todos in todo2

alias weather="curl wttr.in/biysk"

alias pacu="sudo pacman -Syu"
alias pacr="sudo pacman -Rs"
alias pac="sudo pacman -S"
alias pacclean="sudo pacman -Sc"

alias aur="yay -S"
alias auru="yay -Syu"

alias fullclean="git checkout master && make clean && rm -f config.h && git reset --hard origin/master"
alias mclean="make clean && rm -f config.h"
alias gac="git add . && git commit -m"
alias patchd="patch --merge -i"

### Prompt Colors
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM=xterm-256color
fi

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
export GPG_TTY=$(tty)
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
