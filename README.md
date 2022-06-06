# QA Engineer Dotfiles

This repository allows you to install all the tools you'll need to setup a QA engineer environment on your brand new Mac. It is also safe to run this on your previously set-up Mac, with the expectation that it will change some of your system settings. Each action it performs is intended to be non-destructive and you will be prompted before anything is overwritten.

# :warning: A word of warning

While I've done everything I can to ensure that this script is non-destructive, it does make some very opinionated decisions about how your Mac should be set up. You may wish to browse the [macos/set-defaults.sh](https://github.com/eezyinc/qa-dotfiles/blob/master/macos/set-defaults.sh) file to get more familiar with the preferences that will be changed.

The other area this script will modify is your configuration files. These are located in your home directory and usually look like`.zshrc`. If you've not made any modifications to these files - then you're fine. Otherwise you'll be prompted to backup this/these files during the installation process. They will be placed in the same directory they originated in with the `.backup` suffix appended.

If you're on a brand new Mac, there's very little to worry about. Cheers!

# Installation

1. Clone this repository into your home directory. `git clone https://github.com/eezyinc/qa-dotfiles.git ~/.dotfiles`
1. Switch to your new dotfiles directory. `cd ~/.dotfiles`
1. Run the bootstrap installation script. `script/bootstrap`
1. Follow the instructions in your Terminal to complete the installation process.

After completion, you should follow the [post-installation steps](#post-installation) detailed below.

## Frequently Asked Installer Questions

### What does the installer do?

Much of the configuration of MacOS and your terminal is handled through files in your home directory. These files often start with a dot - like `.zshrc`. Hence the name "dotfile". You could scour the web, install a bunch of software (some of which will tell you to update a particular dotfile) all on your own. Instead, we want to shortcut that process for you by providing the dotfiles and softare you can actually use right away.

The installation process does the following things:
1. **Make sure your MacOS software is up to date.** The installer will update your current operating system. This may require a restart of your computer.
1. **Configure MacOS.** Set opinionated defaults optimized for the QA process, like changing your Screenshots folder and speeding up your key repeat rate.
1. **Configure Git.** Ensure git recognizes you as an author. Set some sane defaults and helpful aliases.
1. **Install Apps.** Install all the apps you'll most commonly use. Things like browsers, Slack, screenshot tools, but also command line tools like 1Password-CLI and tree.
1. **Configure Command Line Apps.** Symlink (that's [a fancy name for creating an alias](https://devdojo.com/devdojo/what-is-a-symlink)) the necessary configuration files from `~/.dotfiles` into your home directory.

### The installer is asking if I want to skip, overwrite or backup files. What does that mean?

In the process of symlinking files, we first check if they exist in our target location. If this is the first time running this script, select `[b]ackup` (typing the lowercase-b) or `[B]ackup all` (typing the uppercase-b). Once files are symlinked you will not be prompted to repeat this.

### Why is the installer asking for my computer password?

One of the first steps the installation script takes is to ensure your system software is up to date. This command requires that you input your computer password into your terminal. When you type your password, no characters will be displayed. This is normal. Just hit enter after you've typed it in!

### Is it OK to run the installer more than once?

Yes. A great example of this is after your system software is updated. Just go back into the Terminal, and start at step 2 of the installation instructions. There's no need to re-clone this repository.

# Post-Installation

There are some things that this script can't do automatically (yet). For convenience we've listed them out below.

## Opening apps for the first time

Many newly downloaded applications will prompt you with a security setting when you open them the first time. This is expected. [Read the docs](https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616/mac) for more information.

## Selecting an iTerm2 theme
- A default iTerm theme was installed by this script. You will need to select it in the iTerm preferences pane. In the application menu bar go to `iTerm2 -> Preferences -> Profiles` and select `Eezy Default`.

## Recommended Google Chrome Extensions
- [1Password - Password Manager](https://chrome.google.com/webstore/detail/1password-%E2%80%93-password-mana/aeblfdkhhhdcdjpifhhbdiojplfjncoa) - Easily sign in to sites, generate passwords, and store secure information.
- [Snowplow Analytics Debugger](https://chrome.google.com/webstore/detail/snowplow-analytics-debugg/jbnlcgeengmijcghameodeaenefieedm) - Debug your Snowplow Analytics implementation.
- [Tag Assistant Companion](https://chrome.google.com/webstore/detail/tag-assistant-companion/jmekfmbnaedfebfnmakmokmlfpblbfdm) - Works with Tag Assistant to help troubleshoot installation of gtag.js and Google Tag Manager.
- [Droplr](https://chrome.google.com/webstore/detail/screenshot-screen-recorde/oncaapliomaamlbopdmhmdompfemljhm) - Capture screenshots and screen recordings instantly.
- [Tab Modifier](https://chrome.google.com/webstore/detail/tab-modifier/hcbgadmbdkiilgpifjgcakjehmafcjai) - Automate your tabs, rename tabs based on rules.
- [OneTab](https://chrome.google.com/webstore/detail/onetab/chphlpgkkbolifaimnlloiipkdnihall?hl=en) - Save up to 95% memory and reduce tab clutter.
- [Spectrum](https://chrome.google.com/webstore/detail/spectrum/ofclemegkcmilinpcimpjkfhjfgmhieb) - Instantly test your web page with different types of color vision deficiency.
- [TestRail Helper](https://chrome.google.com/webstore/detail/testrail-helper/bomfcmedmmolncpeaaikehdgcccjllaf?hl=en) - Expands all Actual Results and can add a comment with expected details.
- [Check My Links](https://chrome.google.com/webstore/detail/check-my-links/ojkcdipcgfaekbeaelaapakgnjflfglf) - Crawls through your webpage and looks for broken links.
- [Ranorex Selocity](https://chrome.google.com/webstore/detail/ranorex-selocity/ocgghcnnjekfpbmafindjmijdpopafoe) - Rapidly generate selectors for use in automation
- [BugMagnet](https://chrome.google.com/webstore/detail/bug-magnet/efhedldbjahpgjcneebmbolkalbhckfi) - Exploratory testing assistant. Open source and customizable.
- [FakeFiller](https://chrome.google.com/webstore/detail/fake-filler/bnjjngeaknajbdcgpfkgnonkmififhfo) - A form filler that fills all inputs on a page with fake/dummy data.

## Frequently Asked Post-Installation Questions

### What can I change?

After installation anything you want to change or tweak will be done in `~/.dotfiles`. Because that directory originated as a Git repository, everything is nicely version controlled. However, you should really consider forking this parent repository to ensure that you can version your own changes!

# Customizing and extending dotfiles

Dotfiles are very much meant for customization. If you plan to customize these settings to your personal liking, I suggest first forking the repository, then cloning that new repository into your home directory. This approach gives you more flexibility while still offering the ability to merge in changes from upstream.

## Topical Structure

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "node" — you can simply add a `node` directory and put files in there. Anything with an extension of `.zsh` will get automatically included into your shell. Anything with an extension of `.symlink` will get symlinked without extension into `$HOME` when you run `script/bootstrap`.

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

- [ ] Consider replacing/aliasing `tree` to [broot](https://dystroy.org/broot/)
- [x] Better git difftool like [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- [x] Add CodeOwners file
- [x] [Install VS Code extensions programatically](https://stackoverflow.com/questions/34286515/how-to-install-visual-studio-code-extensions-from-command-line)
- [x] Setup a sane [editorConfig file](https://editorconfig.org/)

## Browser Extensions

- Installing Chrome extensions [appears possible](https://support.google.com/chrome/a/answer/187948?visit_id=637892850139741739-4179064981&rd=1), but a PIA.