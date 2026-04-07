#!/bin/sh
#
# postman/install.sh — Postman via snap (Linux only).
# macOS gets it from the Brewfile.

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v snap >/dev/null 2>&1 || { echo "postman/install.sh: snap not available, skipping"; exit 0; }
snap list postman >/dev/null 2>&1 && exit 0

sudo snap install postman
