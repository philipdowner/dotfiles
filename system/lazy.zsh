# lazy_load — defer expensive shell init until first use.
#
# Usage:
#   lazy_load <real-init-snippet> <command1> [command2 ...]
#
# Defines stub functions for each <command> that, on first invocation,
# `eval` the init snippet, undefine themselves, and re-exec the original
# command. Use this for tools whose `eval "$(... init -)"` blocks add
# noticeable startup latency (nvm, pyenv, rbenv, conda, gcloud, direnv).
#
# Example — wrap nvm so the ~300ms init only runs the first time you actually
# call node/npm/nvm:
#
#   lazy_load 'export NVM_DIR="$HOME/.nvm"; source "$NVM_DIR/nvm.sh"' nvm node npm npx
#
# After running, the next `node --version` works exactly as if nvm had been
# loaded eagerly, but every shell that doesn't touch node stays fast.
#
# Currently this repo has nothing slow enough to need it (asdf is gone, no
# nvm/pyenv/rbenv on the host) — the helper is here so adding lazy stubs
# later is a one-liner.

lazy_load() {
  local init_snippet="$1"; shift
  local cmd
  for cmd in "$@"; do
    eval "
      $cmd() {
        unset -f $* >/dev/null 2>&1
        eval \"$init_snippet\"
        $cmd \"\$@\"
      }
    "
  done
}
