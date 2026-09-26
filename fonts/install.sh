#!/bin/sh
#
# fonts/install.sh
#
# Meslo Nerd Font, which the Oh My Posh agnoster theme needs for its powerline
# separators and icons. On macOS it comes from the Brewfile
# (font-meslo-lg-nerd-font), so this script is a no-op there. On Linux it
# downloads the same font from the Nerd Fonts release into ~/.local/share/fonts.
# Safe to re-run.
#
# The font only matters on the machine running the terminal emulator. On a
# server you SSH into, install it on your local machine instead.

if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

if fc-list 2>/dev/null | grep -q 'MesloLGS Nerd Font'; then
  exit 0
fi

FONT_DIR="$HOME/.local/share/fonts/MesloNerdFont"
TMP_ZIP="$(mktemp)"

echo "› installing Meslo Nerd Font into $FONT_DIR"
mkdir -p "$FONT_DIR"
if curl -fsSL -o "$TMP_ZIP" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip; then
  unzip -oq "$TMP_ZIP" 'MesloLGS*' -d "$FONT_DIR"
  fc-cache -f "$FONT_DIR"
else
  echo "  font download failed; re-run bin/dot to try again."
fi
rm -f "$TMP_ZIP"
