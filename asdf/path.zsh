# Source asdf. macOS uses Homebrew's path; Linux uses ~/.asdf clone.
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . "$HOME/.asdf/asdf.sh"
elif (( $+commands[brew] )) && [ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]; then
  . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
fi
