# https://github.com/romkatv/powerlevel10k#homebrew
# Only source p10k from Homebrew if brew is available (i.e. on macOS).
# On Linux this repo intentionally does not install p10k; oh-my-zsh's
# default theme is used instead.
if (( $+commands[brew] )) && [ -f "$(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" ]; then
  source "$(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme"

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi
