# Philip Downer's Dotfiles

A reproducible developer environment for **macOS** and **Ubuntu/Debian Linux**, set up by a single command. One repo, two OSes, same shell + git config + tooling on both.

> [!NOTE]
> The installer is non-destructive. Anything it would overwrite is moved into a timestamped backup directory first — it never `rm`s a real file.

## Contents

- [Quick start](#quick-start)
- [What you get](#what-you-get)
- [Philosophy](#philosophy)
- [Day-to-day: `dot` commands](#day-to-day-dot-commands)
- [Customization](#customization)
  - [Per-machine config: `~/.localrc`](#per-machine-config-localrc)
  - [Signing git commits with the 1Password SSH agent](#signing-git-commits-with-the-1password-ssh-agent)
  - [Profiling shell startup](#profiling-shell-startup)
- [How it works](#how-it-works)
- [Post-install steps](#post-install-steps)
- [FAQ](#faq)

## Quick start

```sh
git clone https://github.com/philipdowner/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

The bootstrap script will:

1. Prompt for your git author name + email (written to a git-ignored `~/.gitconfig.local`).
2. Symlink every `*.symlink` file into `$HOME` (with timestamped backups of anything pre-existing).
3. Detect your OS and run the right installer chain (`bin/dot install`).

That's it. Re-run `script/bootstrap` or `dot update` any time — both are idempotent.

> [!TIP]
> If you want to customize without losing the ability to pull upstream changes, **fork** the repo first and clone your fork.

## What you get

### Shell
- **zsh** as the default login shell, with [oh-my-zsh](https://ohmyz.sh/) (default `robbyrussell` theme on Linux, [powerlevel10k](https://github.com/romkatv/powerlevel10k) on macOS)
- Topic-based config: drop a `*.zsh` file in any subdirectory and it gets sourced
- `~/.localrc` escape hatch for per-machine secrets and tweaks (see [Customization](#customization))
- Auto-deduped `$PATH`, fast history search, sensible defaults

### Git
- Pre-configured `.gitconfig` with [git-delta](https://github.com/dandavison/delta) as the pager (side-by-side diffs, syntax highlighting)
- **PhpStorm** wired up as `core.editor`, `diff.tool`, and `merge.tool`
- A `~/.gitconfig.local` file for your name/email and any per-machine overrides
- Helpful aliases (`promote`, `wtf`, etc.) — see `git/gitconfig.symlink`

### CLI tools
- `git`, `gh` (GitHub CLI), `curl`, `wget`, `tree`, `tldr`, `jq`, `ripgrep`, `fd`, `shellcheck`, `zsh-syntax-highlighting`
- **Node.js** + **npm** from apt (Linux) or brew (macOS) — for global CLIs only; project Node lives in Docker
- **Claude Code** (`@anthropic-ai/claude-code`) via npm
- **Docker Engine** + Compose v2 (Linux: official apt repo; macOS: Docker Desktop)
- **1Password CLI** (`op`) with the SSH agent integration

### GUI apps

| App | macOS | Linux |
|---|:-:|:-:|
| **PhpStorm** (default IDE) | Toolbox | Toolbox |
| 1Password + 1Password CLI | brew | apt (official repo, **not snap**) |
| Google Chrome | brew | apt (official repo) |
| Slack | brew | snap |
| Zoom | brew | vendor `.deb` |
| Spotify | brew | apt (official repo) |
| Obsidian | brew | snap |
| Postman | brew | snap |
| Docker | Desktop | Engine |
| iTerm2 | brew | — (use GNOME Terminal) |
| Rectangle / Kap / QuickLook plugins | brew | — (macOS-only) |

> [!IMPORTANT]
> **Don't install 1Password from snap.** The snap build is sandboxed and breaks the SSH agent socket. The repo's `1password/install.sh` uses the official apt repo and detects an existing snap install to warn you.

## Philosophy

This repo gives you a **stable, reproducible base shell + tooling environment**, nothing more. The opinions are:

1. **Language runtimes live in Docker.** PHP, MySQL, Postgres, Python, Ruby — none of them are installed system-wide. Each project ships its own container. Node + npm are the only host runtimes, and only because global CLIs need them.
2. **One IDE.** PhpStorm is the canonical editor. Git uses it for diffs, merges, and commit messages.
3. **macOS and Linux at parity where it matters.** The same `.zshrc`, the same `.gitconfig`, the same `dot update` workflow. Differences are isolated to per-OS topic installers.
4. **Opt-in, not opt-out.** New apps are explicit additions (`Aptfile`, `Brewfile`, or a `<topic>/install.sh`). No surprise installs.

## Day-to-day: `dot` commands

After the first install, `bin/dot` is the maintenance entry point:

```sh
dot              # same as `dot install`
dot install      # re-run all installers (idempotent)
dot update       # git pull, install, then upgrade brew/apt + oh-my-zsh
dot edit         # open ~/.dotfiles in PhpStorm
dot help         # show usage
```

`dot update` is the one to run weekly: it `git pull --rebase --autostash`'s the repo, re-runs every topic installer (so new tools you add show up automatically), then upgrades system packages.

## Customization

### Per-machine config: `~/.localrc`

Anything you don't want committed to a public dotfiles repo — work credentials, API tokens, machine-specific `$PATH` entries, hostname-specific aliases — goes in `~/.localrc`. It's sourced at the very top of `~/.zshrc`, before any topic config.

See [`zsh/localrc.example`](zsh/localrc.example) for the canonical patterns:

```sh
# Pull secrets from 1Password at shell-start time, never touching disk
export GITHUB_TOKEN="$(op read 'op://Private/GitHub/token')"

# Hostname-specific tweaks
case "$(hostname -s)" in
  work-laptop)  export AWS_PROFILE=work ;;
  home-desktop) export AWS_PROFILE=personal ;;
esac
```

The `1password/functions.zsh` file also exposes two helpers (gated on `op` being on `$PATH`):

```sh
op_export GITHUB_TOKEN "op://Private/GitHub/token"   # silently no-ops if not signed in
with-op ~/.config/op/work.env -- terraform plan      # `op run` wrapper
```

### Signing git commits with the 1Password SSH agent

The `1password/install.sh` topic enables the SSH agent. You can use the same key to sign your git commits without ever exporting it. Add this to `~/.gitconfig.local`:

```ini
[user]
    signingkey = ssh-ed25519 AAAAC3Nza...your public key...
[gpg]
    format = ssh
[gpg "ssh"]
    program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"   # macOS
    # program = "/opt/1Password/op-ssh-sign"                              # Linux
[commit]
    gpgsign = true
[tag]
    gpgsign = true
```

GitHub will mark your commits as **Verified** with no extra agents and no on-disk private key.

### Profiling shell startup

If your shell starts to feel slow:

```sh
ZSH_PROFILE=1 zsh -ic exit
```

This loads `zsh/zprof` and prints a per-function timing report at the end of zshrc. Use the `lazy_load` helper in [`system/lazy.zsh`](system/lazy.zsh) to defer slow initializers (`nvm`, `pyenv`, `direnv`, etc.) until first use.

## How it works

### Topic structure

Everything is organized by topic — one directory per tool. To add a new topic, just `mkdir node` and drop files in:

| Filename | What it does |
|---|---|
| `topic/path.zsh` | Sourced **first**. Set `$PATH` and friends here. |
| `topic/*.zsh` | Sourced in the middle. Aliases, functions, env vars, prompts. |
| `topic/completion.zsh` | Sourced **last**, after `compinit`. Use for completion definitions. |
| `topic/install.sh` | Run by `script/install` (and `dot install`). Idempotent installer for the tool. |
| `topic/*.symlink` | Symlinked into `$HOME` as `~/.<basename>` by `script/bootstrap`. |
| `bin/*` | Anything in `bin/` is added to `$PATH`. |

Per-OS installers should self-skip with a `[ "$(uname -s)" = "Linux" ] || exit 0` (or equivalent) at the top so they're safe to include in the global install loop on the wrong OS.

### Bootstrap flow

```
script/bootstrap
├── prompt for git name/email → ~/.gitconfig.local
├── symlink */*.symlink → ~ (timestamped backups for anything pre-existing)
└── bin/dot install
    ├── macOS:  macos/set-defaults.sh, homebrew/install.sh, brew update
    ├── Linux:  linux/set-defaults.sh, linux/install.sh (apt + Aptfile)
    └── script/install   # runs every topic */install.sh + Brewfile on macOS
```

### Adding apps

- **CLI tool available in your distro's repos:** add it to [`linux/Aptfile`](linux/Aptfile) and/or [`Brewfile`](Brewfile), then `dot install`.
- **Anything else (vendor apt repo, snap, .deb, tarball):** create a new topic dir with an `install.sh` that follows the pattern in `chrome/`, `1password/`, `docker/`, etc.

## Post-install steps

A few things the installer can't fully automate.

### macOS

- **PhpStorm:** Install via [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/). In Toolbox settings, enable "Generate shell scripts" so the `phpstorm` launcher ends up on your `$PATH`. (Or in PhpStorm: *Tools → Create Command-line Launcher*.)
- **iTerm2 theme:** *iTerm2 → Settings → Profiles* and pick `Dotfiles Default`.
- **Open new apps once:** macOS will prompt for security confirmation the first time you launch any non-App-Store app — this is expected.

### Linux (Ubuntu/Debian)

- **PhpStorm:** Install via [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/). Enable "Generate shell scripts" in Toolbox settings (target `~/.local/bin`). The `phpstorm/install.sh` topic will detect it and symlink the launcher if Toolbox didn't.
- **Log out and back in** after the first install so:
  - your shell switches to zsh, and
  - your user picks up `docker` group membership
- **GNOME Terminal font:** *Preferences → your profile → Custom font*. Pick whichever monospace font you prefer.
- **1Password SSH agent:** Open 1Password → *Settings → Developer → Use the SSH agent*. The `1password/env.zsh` file will export `SSH_AUTH_SOCK` for you on next shell start.

## FAQ

### Is it safe to run on a machine I've already configured?

Yes. Anything pre-existing at a symlink target is moved to `~/.dotfiles-backup/<timestamp>/<original/path>` before being replaced. Restore with `cp -a ~/.dotfiles-backup/<timestamp>/. /`.

### What does it install on a fresh box?

See [What you get](#what-you-get). The Linux installers default to a lean set of base tools — you can extend by editing [`linux/Aptfile`](linux/Aptfile). The macOS Brewfile is broader because brew handles GUI apps too.

### Why is the installer asking for my password?

Several installers (`apt`, system `defaults`, `chsh`) need root. They're prompted via `sudo`; no characters appear as you type — just hit enter.

### Can I run the installer more than once?

Yes — that's exactly what `dot install` and `dot update` do. Every topic installer is idempotent and skips work that's already done.

### How do I customize without forking?

- For **secrets and per-machine env vars**, use `~/.localrc` (see [Customization](#customization)).
- For **git author info** and any local git config, edit `~/.gitconfig.local`.
- For **bigger changes** — adding/removing topics, changing the Brewfile or Aptfile — fork the repo so you can pull upstream changes later.

### Something broke — where do I report it?

[Open an issue](https://github.com/philipdowner/dotfiles/issues) on the repo.
