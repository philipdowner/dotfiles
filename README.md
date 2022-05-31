# QA Engineer Dotfiles

This repository allows you to install all the tools you'll need to setup a QA engineer environment on your brand new Mac. It is also safe to run this on your previously set-up Mac, with the expectation that it will change some of your system settings. Each action it performs is intended to be non-destructive and you will be prompted before anything is overwritten.

# :warning: A word of warning

While I've done everything I can to ensure that this script is non-destructive, it does make some very opinionated decisions about how your Mac should be set up. You may wish to browse the [macos/set-defaults.sh](https://github.com/eezyinc/qa-dotfiles/blob/master/macos/set-defaults.sh) file to get more familiar with the preferences that will be changed.

The other area this script will modify is your configuration files. These are located in your home directory and usually look like`.zshrc`. If you've not made any modifications to these files - then you're fine. Otherwise you'll be prompted to backup this/these files during the installation process. They will be placed in the same directory they originated in with the `.backup` suffix appended.

If you're on a brand new Mac, there's very little to worry about. Cheers!

# Installation

1. Clone this repository into your home directory. `git clone https://github.com/eezyinc/qa-dotfiles.git ~/.dotfiles`
1. Switch to your new dotfiles directory. `cd ~/.dotfiles`
1. Run the install script. `script/install.sh`

This will symlink the appropriate files in `.dotfiles` to your home directory. Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`, which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS defaults, and so on. Tweak this script, and occasionally run `dot` from time to time to keep your environment fresh and up-to-date. You can find this script in `bin/`.

# Post-Installation

There are some things that this script can't do automatically (yet). For convenience we've listed them out below.

## Selecting an iTerm2 theme
- A default iTerm theme named `Eezy Default` was installed by this script. You will need to select it in the iTerm preferences pane under `Profiles`.

## Recommended Google Chrome Extensions
- [1Password - Password Manager](https://chrome.google.com/webstore/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa)
- [Snowplow Analytics Debugger](https://chrome.google.com/webstore/detail/snowplow-analytics-debugg/jbnlcgeengmijcghameodeaenefieedm)
- [Tag Assistant Companion](https://chrome.google.com/webstore/detail/tag-assistant-companion/jmekfmbnaedfebfnmakmokmlfpblbfdm)
- [Droplr](https://chrome.google.com/webstore/detail/screenshot-screen-recorde/oncaapliomaamlbopdmhmdompfemljhm)
- [Tab Modifier](https://chrome.google.com/webstore/detail/tab-modifier/hcbgadmbdkiilgpifjgcakjehmafcjai)

## Recommended VS Code Extensions
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

# Customizing and extending dotfiles

Dotfiles are very much meant for customization. If you plan to customize these settings to your personal liking, I suggest first forking the repository, then cloning that new repository into your home directory. This approach gives you more flexibility while still offering the ability to merge in changes from upstream.

## Topical Structure

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "node" — you can simply add a `node` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## What's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser above and see what components may mesh up with you. The best place to start is probably [the Brewfile](https://github.com/eezyinc/qa-dotfiles/blob/master/Brewfile). [Fork this repo](https://github.com/eezyinc/qa-dotfiles/fork), remove what you don't use, and build on what you do use.

## Components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into your `$HOME`. This is so you can keep all of those versioned in your dotfiles but still keep those autoloaded files in your home directory. These get symlinked in when you run `script/bootstrap`.

## Bugs

I want this to work for everyone. If you run into any blockers, please [open an issue](https://github.com/eezyinc/qa-dotfiles/issues) on this repository and we'll work to get it fixed for you!

# Errata and To-Do's

## @todo

- [ ] [Install VS Code extensions programatically](https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line)
- [x] Automatically configure iTerm via Dynamic Profiles

## Browser Extensions

- Installing Chrome extensions [appears possible](https://support.google.com/chrome/a/answer/187948?visit_id=637892850139741739-4179064981&rd=1), but a PIA.