# 1Password CLI helper functions.
#
# Available once you have `op` on your PATH (installed via the brew cask on
# macOS or 1password/install.sh on Linux). All helpers are no-ops if op is
# missing, so the file is safe to source unconditionally.

(( $+commands[op] )) || return 0

# op_export NAME "op://Vault/Item/field"
#
# Look up a 1Password reference and export it as an env var. Useful from
# ~/.localrc to keep tokens out of the dotfiles repo and off disk:
#
#   op_export GITHUB_TOKEN  "op://Private/GitHub/token"
#   op_export OPENAI_API_KEY "op://Private/OpenAI/api key"
#
# Silently no-ops if you're not signed in (so a fresh shell on a new machine
# doesn't error out before `op signin`).
op_export() {
  local name="$1" ref="$2"
  local value
  value=$(op read "$ref" 2>/dev/null) || return 0
  export "$name=$value"
}

# with-op <env-file> -- <command...>
#
# Run a command with secrets from an op env file injected into its
# environment, without ever writing them to disk. Thin wrapper around
# `op run` that gives you a more memorable name.
#
#   with-op ~/.config/op/work.env -- terraform plan
with-op() {
  op run --env-file="$1" -- "${@:2}"
}
