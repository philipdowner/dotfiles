# Auto-deduplicate PATH and MANPATH so the same entry can't sneak in twice
# after months of installer reruns. zsh built-in; must come before any export.
typeset -U path PATH
typeset -U manpath MANPATH

export PATH="./bin:/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$HOME/.local/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/share/man:/usr/local/git/man:$MANPATH"
