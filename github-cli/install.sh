#!/bin/sh
#
# github-cli/install.sh
#
# Installs GitHub CLI (`gh`) from GitHub's official apt repo on Linux.
# macOS gets `gh` from the Brewfile.
#
# https://github.com/cli/cli/blob/trunk/docs/install_linux.md

set -e

if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

if ! command -v apt-get >/dev/null 2>&1; then
  exit 0
fi

if command -v gh >/dev/null 2>&1; then
  exit 0
fi

KEYRING=/usr/share/keyrings/githubcli-archive-keyring.gpg
LIST=/etc/apt/sources.list.d/github-cli.list

if [ ! -f "$KEYRING" ]; then
  echo "› importing GitHub CLI signing key"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of="$KEYRING"
  sudo chmod go+r "$KEYRING"
fi

if [ ! -f "$LIST" ]; then
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING] https://cli.github.com/packages stable main" \
    | sudo tee "$LIST" >/dev/null
fi

sudo apt-get update -y
sudo apt-get install -y gh
