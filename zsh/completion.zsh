# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# arrow-key selectable completion menu with coloured entries
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# cache slow completions (e.g. brew, apt, docker)
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"
