#!/bin/sh
#
# oh-my-posh/install.sh
#
# Oh My Posh prompt engine (https://ohmyposh.dev). On macOS it comes from the
# Brewfile, so this script is a no-op there. On Linux it installs the binary
# into ~/.local/bin and the bundled themes into ~/.local/share/oh-my-posh/themes,
# which is where zsh/zshrc.symlink looks for the agnoster theme. Safe to re-run.

if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

if [ -x "$HOME/.local/bin/oh-my-posh" ] || command -v oh-my-posh >/dev/null 2>&1; then
  exit 0
fi

echo "› installing oh-my-posh"
mkdir -p "$HOME/.local/bin" "$HOME/.local/share/oh-my-posh/themes"
curl -fsSL https://ohmyposh.dev/install.sh | bash -s -- \
  -d "$HOME/.local/bin" \
  -t "$HOME/.local/share/oh-my-posh/themes" \
  || echo "  oh-my-posh install failed; re-run bin/dot to try again."
