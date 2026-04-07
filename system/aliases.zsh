# Colorized ls aliases.
# Linux ships GNU coreutils as `ls`. macOS users can `brew install coreutils`
# to get GNU ls as `gls`. Prefer GNU when available, fall back to BSD ls.
if command -v gls >/dev/null 2>&1; then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la="gls -A --color"
elif ls --color=auto >/dev/null 2>&1; then
  # GNU ls (Linux)
  alias ls="ls -F --color=auto"
  alias l="ls -lAh --color=auto"
  alias ll="ls -l --color=auto"
  alias la="ls -A --color=auto"
else
  # BSD ls (stock macOS)
  alias ls="ls -FG"
  alias l="ls -lAhG"
  alias ll="ls -lG"
  alias la="ls -AG"
fi
