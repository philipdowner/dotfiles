#!/bin/sh
#
# chrome/install.sh — Google Chrome from the official apt repo (Linux only).
# macOS gets it from the Brewfile.

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v apt-get >/dev/null 2>&1 || exit 0
command -v google-chrome >/dev/null 2>&1 && exit 0

KEYRING=/usr/share/keyrings/google-chrome.gpg
LIST=/etc/apt/sources.list.d/google-chrome.list

if [ ! -f "$KEYRING" ]; then
  curl -fsSL https://dl.google.com/linux/linux_signing_key.pub \
    | sudo gpg --dearmor --output "$KEYRING"
fi

if [ ! -f "$LIST" ]; then
  echo "deb [arch=amd64 signed-by=$KEYRING] https://dl.google.com/linux/chrome/deb/ stable main" \
    | sudo tee "$LIST" >/dev/null
fi

sudo apt-get update -y
sudo apt-get install -y google-chrome-stable
