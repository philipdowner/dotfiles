#!/bin/sh
#
# phpstorm/install.sh
#
# Ensures the `phpstorm` shell launcher is on $PATH on Linux. JetBrains
# Toolbox manages PhpStorm under ~/.local/share/JetBrains/Toolbox/apps and
# (when "Generate shell scripts" is enabled in Toolbox → Settings) drops a
# launcher into ~/.local/bin/phpstorm automatically — in which case this
# script is a no-op.
#
# Otherwise we look for a Toolbox install and symlink its phpstorm.sh into
# ~/.local/bin/phpstorm.
#
# On macOS, a PhpStorm installed from Toolbox or with "Tools → Create
# Command-line Launcher" already provides the launcher. Otherwise we symlink the
# app bundle's binary into ~/.local/bin/phpstorm.

set -e

if command -v phpstorm >/dev/null 2>&1 || [ -e "$HOME/.local/bin/phpstorm" ]; then
  exit 0
fi

if [ "$(uname -s)" = "Darwin" ]; then
  APP_BIN="/Applications/PhpStorm.app/Contents/MacOS/phpstorm"
  if [ -x "$APP_BIN" ]; then
    mkdir -p "$HOME/.local/bin"
    echo "› symlinking $APP_BIN → ~/.local/bin/phpstorm"
    ln -sf "$APP_BIN" "$HOME/.local/bin/phpstorm"
  fi
  exit 0
fi

if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

mkdir -p "$HOME/.local/bin"

# Try the modern Toolbox layout first, then the legacy one.
CANDIDATE="$(ls -1d "$HOME/.local/share/JetBrains/Toolbox/apps/phpstorm/bin/phpstorm.sh" 2>/dev/null | head -n1)"
if [ -z "$CANDIDATE" ]; then
  CANDIDATE="$(ls -1d "$HOME/.local/share/JetBrains/Toolbox/apps/PhpStorm"*/*/bin/phpstorm.sh 2>/dev/null | head -n1)"
fi
if [ -z "$CANDIDATE" ]; then
  CANDIDATE="$(ls -1d /opt/phpstorm*/bin/phpstorm.sh 2>/dev/null | head -n1)"
fi

if [ -z "$CANDIDATE" ]; then
  cat <<'MSG'
phpstorm/install.sh: could not find a PhpStorm install.

Install PhpStorm via JetBrains Toolbox (recommended) or download the tarball
to /opt/phpstorm, then re-run `bin/dot`. To get the launcher automatically,
open Toolbox → Settings and enable "Generate shell scripts" pointing at
~/.local/bin.
MSG
  exit 0
fi

echo "› symlinking $CANDIDATE → ~/.local/bin/phpstorm"
ln -sf "$CANDIDATE" "$HOME/.local/bin/phpstorm"
