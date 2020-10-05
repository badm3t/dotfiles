#
# ~/.bashrc
#
source ~/dotfiles/git-completion.bash
source ~/dotfiles/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1

GREEN="\[$(tput setaf 2)\]"
BLUE="\[$(tput setaf 4)\]"
RESET="\[$(tput sgr0)\]"

GIT='\[$(__git_ps1 " (%s)")\]'

export PS1="${GREEN}\w ${BLUE}${GIT}${RESET}\$: "
export P22="> "



[ -n "$PS1" ] && source ~/.bash_profile
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.emacs.d/bin:$PATH"
#export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/nvidia_icd.json"

[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
      . /usr/share/bash-completion/bash_completion
