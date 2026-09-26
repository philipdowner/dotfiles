# Put Homebrew on $PATH and set $HOMEBREW_PREFIX, so a new Mac doesn't need the
# `brew shellenv` line the Homebrew installer asks you to add to ~/.zprofile.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
