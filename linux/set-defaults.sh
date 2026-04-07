#!/bin/sh
#
# linux/set-defaults.sh
#
# GNOME / Ubuntu desktop defaults — the Linux peer of macos/set-defaults.sh.
# Uses `gsettings` for everything so it's safe to re-run and works on any
# GNOME-based desktop (Ubuntu, Fedora Workstation, Pop!_OS).
#
# Skips silently when:
#   - not running Linux
#   - gsettings is not installed (e.g. headless box, KDE, sway)

set -e

[ "$(uname -s)" = "Linux" ] || exit 0
command -v gsettings >/dev/null 2>&1 || exit 0

set_gs() {
  # set_gs <schema> <key> <value>
  # Idempotent and quiet — gsettings handles re-application fine, but we
  # only echo when something actually changes to keep output tidy.
  current=$(gsettings get "$1" "$2" 2>/dev/null || echo "")
  if [ "$current" != "$3" ]; then
    gsettings set "$1" "$2" "$3" 2>/dev/null && echo "  set $1 $2 = $3" || true
  fi
}

###############################################################################
# Screenshots                                                                 #
###############################################################################
# GNOME 42+ stores screenshots in ~/Pictures/Screenshots by default. Make
# sure that directory exists so the screenshot tool doesn't fall back to
# the desktop on first use.
mkdir -p "${HOME}/Pictures/Screenshots"

###############################################################################
# Input devices                                                               #
###############################################################################
# Tap-to-click on touchpad
set_gs org.gnome.desktop.peripherals.touchpad tap-to-click true

# Fast key repeat to match the macOS settings
set_gs org.gnome.desktop.peripherals.keyboard delay 'uint32 200'
set_gs org.gnome.desktop.peripherals.keyboard repeat-interval 'uint32 25'

###############################################################################
# Appearance                                                                  #
###############################################################################
# Dark mode by default
set_gs org.gnome.desktop.interface color-scheme "'prefer-dark'"
set_gs org.gnome.desktop.interface gtk-theme "'Adwaita-dark'"

# Show battery percentage in the top bar (no-op on desktops)
set_gs org.gnome.desktop.interface show-battery-percentage true

###############################################################################
# Nautilus (file manager)                                                     #
###############################################################################
# List view, sorted by name, show hidden files (the Linux equivalent of the
# Finder defaults in macos/set-defaults.sh).
set_gs org.gnome.nautilus.preferences default-folder-viewer "'list-view'"
set_gs org.gnome.nautilus.preferences show-hidden-files true
set_gs org.gtk.Settings.FileChooser show-hidden true
set_gs org.gtk.gtk4.Settings.FileChooser show-hidden true

###############################################################################
# Window management                                                           #
###############################################################################
# Minimize/maximize/close buttons (Ubuntu hides minimize+maximize by default)
set_gs org.gnome.desktop.wm.preferences button-layout "'appmenu:minimize,maximize,close'"
