#!/bin/sh
#
# spotify/install.sh — Spotify from the official apt repo (Linux only).
# macOS gets it from the Brewfile.
# https://www.spotify.com/download/linux/

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v apt-get >/dev/null 2>&1 || exit 0
command -v spotify >/dev/null 2>&1 && exit 0

KEYRING=/usr/share/keyrings/spotify.gpg
LIST=/etc/apt/sources.list.d/spotify.list

if [ ! -f "$KEYRING" ]; then
  curl -fsSL https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg \
    | sudo gpg --dearmor --output "$KEYRING"
fi

if [ ! -f "$LIST" ]; then
  echo "deb [signed-by=$KEYRING] https://repository.spotify.com stable non-free" \
    | sudo tee "$LIST" >/dev/null
fi

sudo apt-get update -y
sudo apt-get install -y spotify-client
