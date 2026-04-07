#!/bin/sh
#
# Homebrew (macOS only)
#
# This installs Homebrew on macOS. On Linux this dotfiles repo uses apt
# (see linux/install.sh) instead of Homebrew, so this script is a no-op there.

if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

exit 0
