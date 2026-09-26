#!/bin/sh
#
# zoom/install.sh — Zoom desktop from Zoom's stable .deb (Linux only).
# macOS gets it from the Brewfile.

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v apt-get >/dev/null 2>&1 || exit 0
command -v zoom >/dev/null 2>&1 && exit 0

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "› downloading zoom .deb"
curl -fsSL -o "$TMP/zoom.deb" https://zoom.us/client/latest/zoom_amd64.deb
sudo apt-get install -y "$TMP/zoom.deb"
