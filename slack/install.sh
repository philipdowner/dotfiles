#!/bin/sh
#
# slack/install.sh — Slack desktop via snap (Linux only).
# Snap is fine for Slack — the 1Password SSH-agent caveat does not apply.
# macOS gets it from the Brewfile.

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v snap >/dev/null 2>&1 || { echo "slack/install.sh: snap not available, skipping"; exit 0; }
snap list slack >/dev/null 2>&1 && exit 0

sudo snap install slack
