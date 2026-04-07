#!/bin/sh
#
# linux/install.sh
#
# Installs apt packages from linux/Aptfile and sets zsh as the default shell.
# Safe to re-run.

set -e

# Only run on Linux
if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

# Only handle Debian/Ubuntu (apt) systems for now.
if ! command -v apt-get >/dev/null 2>&1; then
  echo "linux/install.sh: apt-get not found; skipping (only Debian/Ubuntu is supported)."
  exit 0
fi

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
APTFILE="$DOTFILES/linux/Aptfile"

if [ ! -f "$APTFILE" ]; then
  echo "linux/install.sh: $APTFILE not found"
  exit 1
fi

echo "› apt-get update"
sudo apt-get update -y

# Read Aptfile, strip comments + blanks, install in one shot.
PACKAGES=$(grep -vE '^\s*(#|$)' "$APTFILE" | tr '\n' ' ')
if [ -n "$PACKAGES" ]; then
  echo "› apt-get install: $PACKAGES"
  # shellcheck disable=SC2086
  sudo apt-get install -y --no-install-recommends $PACKAGES
fi

# --- Make zsh the default shell --------------------------------------------
if command -v zsh >/dev/null 2>&1 && [ "$(basename "$SHELL")" != "zsh" ]; then
  echo "› setting zsh as default shell (you may be prompted for your password)"
  chsh -s "$(command -v zsh)" || echo "  could not change shell automatically; run: chsh -s \$(which zsh)"
fi

echo "linux/install.sh: done"
