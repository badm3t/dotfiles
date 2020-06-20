#
# ~/.bashrc
#
[ -n "$PS1" ] && source ~/.bash_profile
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.emacs.d/bin:$PATH"
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/nvidia_icd.json"
