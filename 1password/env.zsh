# Point ssh at the 1Password SSH agent if it's running.
# Linux: socket lives at ~/.1password/agent.sock
# macOS: ~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock
if [ -S "$HOME/.1password/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
elif [ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi
