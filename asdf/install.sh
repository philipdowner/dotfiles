#!/bin/sh
#
# asdf/install.sh
#
# Installs asdf (if missing) and configures the ruby + nodejs plugins.
# On macOS asdf is provided by Homebrew (Brewfile). On Linux we git-clone it.

set -e

source "$DOTFILES/functions/log"

# --- Install asdf itself if missing ----------------------------------------
if ! command -v asdf >/dev/null 2>&1 && [ ! -d "$HOME/.asdf" ]; then
  if [ "$(uname -s)" = "Linux" ]; then
    info "installing asdf into ~/.asdf"
    git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf" --branch v0.14.1
  fi
fi

# Source asdf so the rest of this script can use it.
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  # shellcheck disable=SC1091
  . "$HOME/.asdf/asdf.sh"
fi

if ! command -v asdf >/dev/null 2>&1; then
  echo "asdf/install.sh: asdf is not available, skipping plugin setup"
  exit 0
fi

configure_asdf() {
  info "configuring asdf"
  asdf plugin-add ruby   2>/dev/null || true
  asdf plugin-add nodejs 2>/dev/null || true
  asdf plugin-update --all
  # run asdf install twice because sometimes language installs exit with
  # non-zero codes even if the install succeeds (looking at you, Erlang)
  cd "$HOME" && asdf install && asdf install

  echo ""
  success "asdf configuration complete!"
}

configure_asdf
