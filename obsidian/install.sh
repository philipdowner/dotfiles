#!/bin/sh
#
# obsidian/install.sh — Obsidian via snap (Linux only).
# macOS gets it from the Brewfile.

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v snap >/dev/null 2>&1 || { echo "obsidian/install.sh: snap not available, skipping"; exit 0; }
snap list obsidian >/dev/null 2>&1 && exit 0

sudo snap install obsidian --classic
