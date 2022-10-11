#!/bin/sh

#-------------------------------------------
# PowerLevel10K Theme for Oh My ZSH
# https://github.com/romkatv/powerlevel10k#oh-my-zsh
#-------------------------------------------
if [ -d ${HOME}/.oh-my-zsh ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi
