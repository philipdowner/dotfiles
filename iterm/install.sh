#!/bin/sh

# iTerm2 is macOS-only.
if [ "$(uname -s)" != "Darwin" ]; then
  exit 0
fi

ITERM_PROFILE_DIR='/Library/Application Support/iTerm2/DynamicProfiles'
ITERM_PROFILE_FILENAME='default-iterm2-profile.json'

mkdir -p "${HOME}${ITERM_PROFILE_DIR}"

# The repo copy is the source of truth and is re-copied on every install.
# iTerm writes changes made in its Settings UI back to the installed copy
# ("Rewritable"), so copy those into the repo before re-running bin/dot.
cp "$DOTFILES/iterm/$ITERM_PROFILE_FILENAME" "${HOME}${ITERM_PROFILE_DIR}/${ITERM_PROFILE_FILENAME}"
