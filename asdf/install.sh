#!/bin/sh

source $DOTFILES/functions/log

configure_asdf() {
  info "configuring asdf"
  asdf plugin-add ruby
  asdf plugin-add nodejs
  asdf plugin-update --all
  # run asdf install twice because sometimes language installs exit with
  # non-zero codes even if the install succeeds (looking at you, Erlang)
  cd $HOME && asdf install && asdf install

  echo ""
  success "asdf configuration complete!"
}

configure_asdf