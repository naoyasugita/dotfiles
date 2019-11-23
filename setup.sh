#!/bin/bash
set -euo pipefail

source lib/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

: "install brew" && {
  if ! command_exists brew; then
    info "installing brew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    warn "brew is already installed"
  fi
}

: "install zsh by brew" && {
  if ! command_exists zsh; then
    info "installing zsh..."
    brew install zsh zsh-completions
    sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells'
    chsh -s $(brew --prefix)/bin/zsh
  else
    warn "zsh is already installed"
  fi
}

: "install other packages by brew" && {
  packages=( jq tree wget direnv vim git pyenv pyenv-virtualenv npm mysql caskroom/cask/brew-cask )
  for package in ${packages[@]}; do
    if ! brew list | grep $package &> /dev/null; then
      info "installing ${package}..."
      brew install ${package}
    else
      warn "${package} is already installed"
    fi
  done
  brew cleanup
}

: "install brew cask" && {
  packages=( google-chrome alfred iterm2 google-japanese-ime slack \
   visual-studio-code flux karabiner clipy )
  for package in ${packages[@]}; do
    if ! brew cask list | grep $package &> /dev/null; then
      info "installing ${package}..."
      brew cask install ${package}
    else
      warn "${package} is already installed"
    fi
  done
  brew cask cleanup
}

: "install oh-my-zsh" && {
  if [ ! -e $HOME/.oh-my-zsh ]; then
    info "installing oh-my-zsh..."
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install
    info "installing zsh theme..."
    git clone https://github.com/wesbos/Cobalt2-iterm.git
    cd Cobalt2-iterm
    cp cobalt2.zsh-theme ~/.oh-my-zsh/themes/
  else
    warn "oh-my-zsh is already installed"
  fi
}

ok "Complete!"
