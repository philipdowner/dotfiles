#!/bin/sh
#
# 1password/install.sh
#
# Installs the 1Password desktop app + the `op` CLI from 1Password's official
# apt repo on Debian/Ubuntu.
#
# IMPORTANT: do NOT install 1Password from snap. The snap build is sandboxed
# and cannot expose its SSH agent socket to other processes, which breaks
# `op ssh` / the 1Password SSH agent integration.
#
# Source: https://support.1password.com/install-linux/
#         https://developer.1password.com/docs/cli/get-started/
#
# macOS gets 1Password from the Brewfile (cask). No-op there.

set -e

if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

if ! command -v apt-get >/dev/null 2>&1; then
  exit 0
fi

# If a snap version is installed, warn the user — we won't auto-remove it,
# but it will conflict with the SSH agent integration.
if command -v snap >/dev/null 2>&1 && snap list 1password >/dev/null 2>&1; then
  echo "!! 1password is currently installed via snap."
  echo "!! The snap build is sandboxed and breaks the SSH agent integration."
  echo "!! Remove it with:  sudo snap remove 1password"
  echo "!! Then re-run this script."
fi

NEED_INSTALL=0
command -v 1password >/dev/null 2>&1 || NEED_INSTALL=1
command -v op         >/dev/null 2>&1 || NEED_INSTALL=1

if [ "$NEED_INSTALL" -eq 0 ]; then
  echo "1password/install.sh: 1password + op already installed, skipping"
  exit 0
fi

KEYRING=/usr/share/keyrings/1password-archive-keyring.gpg
LIST=/etc/apt/sources.list.d/1password.list
DEBSIG_POLICY_DIR=/etc/debsig/policies/AC2D62742012EA22
DEBSIG_KEYRING_DIR=/usr/share/debsig/keyrings/AC2D62742012EA22

# 1. Import the signing key.
if [ ! -f "$KEYRING" ]; then
  echo "› importing 1Password signing key"
  curl -sSf https://downloads.1password.com/linux/keys/1password.asc \
    | sudo gpg --dearmor --output "$KEYRING"
fi

# 2. Add the apt repository.
if [ ! -f "$LIST" ]; then
  echo "› adding 1Password apt repository"
  echo "deb [arch=$(dpkg --print-architecture) signed-by=$KEYRING] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" \
    | sudo tee "$LIST" >/dev/null
fi

# 3. Set up debsig-verify policy so apt verifies package signatures.
if [ ! -f "$DEBSIG_POLICY_DIR/1password.pol" ]; then
  echo "› installing 1Password debsig-verify policy"
  sudo mkdir -p "$DEBSIG_POLICY_DIR" "$DEBSIG_KEYRING_DIR"
  curl -sSf https://downloads.1password.com/linux/debian/debsig/1password.pol \
    | sudo tee "$DEBSIG_POLICY_DIR/1password.pol" >/dev/null
  curl -sSf https://downloads.1password.com/linux/keys/1password.asc \
    | sudo gpg --dearmor --output "$DEBSIG_KEYRING_DIR/debsig.gpg"
fi

# 4. Install.
sudo apt-get update -y
sudo apt-get install -y 1password 1password-cli

echo "1password/install.sh: done"
echo "   Enable the SSH agent under: 1Password → Settings → Developer →"
echo "   'Use the SSH agent', then add to your shell:"
echo "     export SSH_AUTH_SOCK=~/.1password/agent.sock"
