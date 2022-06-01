#!/bin/sh

ITERM_PROFILE_DIR="${HOME}/Library/Application\ Support/iTerm2/DynamicProfiles"
ITERM_PROFILE_FILENAME="eezy-default-iterm2-profile.json" 

mkdir -p $ITERM_PROFILE_DIR

if [ ! -r "${ITERM_PROFILE_DIR}/${ITERM_PROFILE_FILENAME}" ]; then
    cp "${DOTFILES}/iterm/${ITERM_PROFILE_FILENAME} "${ITERM_PROFILE_DIR}/${ITERM_PROFILE_FILENAME}
fi