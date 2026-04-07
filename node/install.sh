#!/bin/sh
#
# node/install.sh
#
# Installs nvm (Node Version Manager). Safe to re-run.

set -e

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
NVM_VERSION="${NVM_VERSION:-v0.40.1}"

if [ -s "$NVM_DIR/nvm.sh" ]; then
  echo "node/install.sh: nvm already installed at $NVM_DIR"
  exit 0
fi

echo "› installing nvm $NVM_VERSION to $NVM_DIR"

if command -v git >/dev/null 2>&1; then
  git clone --branch "$NVM_VERSION" --depth 1 https://github.com/nvm-sh/nvm.git "$NVM_DIR"
elif command -v curl >/dev/null 2>&1; then
  PROFILE=/dev/null curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | PROFILE=/dev/null sh
else
  echo "node/install.sh: need git or curl to install nvm" >&2
  exit 1
fi

echo "node/install.sh: done"
