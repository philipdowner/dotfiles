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
# macOS users get the launcher from JetBrains Toolbox or from PhpStorm's
# "Tools → Create Command-line Launcher" menu item — nothing to do here.

set -e

if [ "$(uname -s)" != "Linux" ]; then
  exit 0
fi

if command -v phpstorm >/dev/null 2>&1; then
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
