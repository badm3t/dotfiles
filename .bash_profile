#
# ~/.bash_profile
#
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/go/bin"
PATH="$PATH:$HOME/bin"

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
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
		MAGENTA=$(tput setaf 4)
		ORANGE=$(tput setaf 172)
		GREEN=$(tput setaf 190)
		PURPLE=$(tput setaf 141)
	else
		MAGENTA=$(tput setaf 5)
		ORANGE=$(tput setaf 4)
		GREEN=$(tput setaf 2)
		PURPLE=$(tput setaf 1)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	MAGENTA="\033[1;31m"
	ORANGE="\033[1;33m"
	GREEN="\033[1;32m"
	PURPLE="\033[1;35m"
	BOLD=""
	RESET="\033[m"
fi

export MAGENTA
export ORANGE
export GREEN
export PURPLE
export BOLD
export RESET

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="→ "

export PS1="\[${MAGENTA}\]\u \[$RESET\]in \[$MAGENTA\]\w\[$RESET\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$RESET\]\n$symbol\[$RESET\]"
export PS2="\[$ORANGE\]→ \[$RESET\]"

### Misc

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
export GPG_TTY=$(tty)
export PATH="$HOME/.rbenv/bin:$PATH"

eval "$(rbenv init -)"
