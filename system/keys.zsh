# Pipe my public key to my clipboard.
# Picks the right clipboard tool for the current OS:
#   - macOS:   pbcopy
#   - Wayland: wl-copy
#   - X11:     xclip
if command -v pbcopy >/dev/null 2>&1; then
  alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo '=> Public key copied to pasteboard.'"
elif command -v wl-copy >/dev/null 2>&1; then
  alias pubkey="cat ~/.ssh/id_rsa.pub | wl-copy && echo '=> Public key copied to clipboard.'"
elif command -v xclip >/dev/null 2>&1; then
  alias pubkey="cat ~/.ssh/id_rsa.pub | xclip -selection clipboard && echo '=> Public key copied to clipboard.'"
fi
