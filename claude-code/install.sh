#!/bin/sh
#
# claude-code/install.sh
#
# Installs Anthropic's Claude Code CLI globally via npm.
# Node + npm come from apt on Linux (see linux/Aptfile) or Homebrew on macOS.

set -e

if command -v claude >/dev/null 2>&1; then
  echo "claude-code/install.sh: claude already installed, skipping"
  exit 0
fi

if ! command -v npm >/dev/null 2>&1; then
  echo "claude-code/install.sh: npm not found — install Node first, then re-run bin/dot"
  exit 0
fi

echo "› npm install -g @anthropic-ai/claude-code"
# On Linux, apt-installed npm puts global packages under /usr/lib/node_modules
# which needs sudo. On macOS Homebrew npm uses a user-writable prefix.
if [ "$(uname -s)" = "Linux" ]; then
  sudo npm install -g @anthropic-ai/claude-code
else
  npm install -g @anthropic-ai/claude-code
fi

echo "claude-code/install.sh: done"
