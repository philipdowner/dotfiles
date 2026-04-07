# GRC colorizes nifty unix tools all over the place.
if (( $+commands[grc] )); then
  if (( $+commands[brew] )) && [ -f "$(brew --prefix)/etc/grc.bashrc" ]; then
    source "$(brew --prefix)/etc/grc.bashrc"
  elif [ -f /etc/grc.zsh ]; then
    source /etc/grc.zsh
  elif [ -f /etc/grc.bashrc ]; then
    source /etc/grc.bashrc
  fi
fi
