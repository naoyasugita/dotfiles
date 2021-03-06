#!/bin/bash
set -euo pipefail

source lib/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

info "==============install brew================"
: "install brew" && {
  if ! command_exists brew; then
    info "installing brew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
    warn "brew is already installed"
  fi
}

info "==============install zsh by brew================"
: "install zsh by brew" && {
  if ! command_exists zsh; then
    info "installing zsh..."
    brew install zsh zsh-completions
    sudo sh -c 'echo $(brew --prefix)/bin/zsh >> /etc/shells'
    chsh -s $(brew --prefix)/bin/zsh
  else
    warn "zsh is already installed"
  fi
  rm -rf ~/.zsh.d ~/.zshrc
  ln -s ~/dotfiles/.zsh.d ~/.zsh.d
  ln -s ~/dotfiles/.zshrc ~/.zshrc
}

info "==============install other packages by brew================"
: "install other packages by brew" && {
  packages=( jq tree wget direnv vim git pyenv pyenv-virtualenv mysql docker )
  for package in ${packages[@]}; do
    if command_exists node; then
      if ! brew list | grep $package &> /dev/null; then
        info "installing ${package}..."
        brew install ${package}
      else
        warn "${package} is already installed"
      fi
    fi
  done
  brew cleanup
}

info "==============install brew cask================"
: "install brew cask" && {
  packages=( google-chrome alfred iterm2 google-japanese-ime slack \
   visual-studio-code flux karabiner-elements clipy docker)
  for package in ${packages[@]}; do
    if ! brew cask list | grep $package &> /dev/null; then
      info "installing ${package}..."
      brew cask install ${package}
    else
      warn "${package} is already installed"
    fi
  done
}

info "==============install oh-my-zsh================"
: "install oh-my-zsh" && {
  if [ ! -e $HOME/.oh-my-zsh ]; then
    info "installing oh-my-zsh..."
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  else
    warn "oh-my-zsh is already installed"
  fi
  info "installing zsh theme..."
  git clone https://github.com/wesbos/Cobalt2-iterm.git
  cd Cobalt2-iterm && cp cobalt2.zsh-theme ~/.oh-my-zsh/themes/
  cd ../ && rm -rf Cobalt2-iterm
}

info "==============install flutter================"
: "install flutter" && {
  if ! command_exists flutter; then
    info "installing flutter..."
    git clone https://github.com/flutter/flutter.git -b stable
  else
    warn "flutter is already installed"
  fi
}

info "==============setting vscode================"
: "setting vscode" && {
  info "create symbolic..."
  SCRIPT_DIR=$(cd $(dirname $0) && pwd)
  VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

  rm -rf "$VSCODE_SETTING_DIR/settings.json"
  ln -s "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
}

ok "Complete!"
