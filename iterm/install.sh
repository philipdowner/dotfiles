#!/bin/sh

ITERM_PROFILE_DIR='/Library/Application Support/iTerm2/DynamicProfiles'
ITERM_PROFILE_FILENAME='default-iterm2-profile.json'

mkdir -p "${HOME}${ITERM_PROFILE_DIR}"

if [ ! -r "${ITERM_PROFILE_DIR}/${ITERM_PROFILE_FILENAME}" ]; then
    cp "$DOTFILES/iterm/$ITERM_PROFILE_FILENAME" "${HOME}${ITERM_PROFILE_DIR}/${ITERM_PROFILE_FILENAME}"
fi
