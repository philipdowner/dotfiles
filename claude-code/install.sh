#!/bin/sh
#
# claude-code/install.sh
#
# Installs Anthropic's Claude Code CLI globally via npm.
# Requires node + npm — provided on this box by asdf (see asdf/install.sh),
# so this runs after that topic when bin/dot iterates installers.

set -e

if command -v claude >/dev/null 2>&1; then
  echo "claude-code/install.sh: claude already installed ($(claude --version 2>/dev/null || echo unknown)), skipping"
  exit 0
fi

# Make sure asdf-managed shims are on PATH for this script.
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  # shellcheck disable=SC1091
  . "$HOME/.asdf/asdf.sh"
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "claude-code/install.sh: npm not found — install Node via asdf first, then re-run bin/dot"
  exit 0
fi

echo "› npm install -g @anthropic-ai/claude-code"
npm install -g @anthropic-ai/claude-code

echo "claude-code/install.sh: done"
