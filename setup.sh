#!/bin/bash
set -euo pipefail

source lib/echos.sh

function command_exists() {
  type "$1" &> /dev/null ;
}

function install_powerline() {
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd ..
  rm -rf fonts
}

info "==============install brew================"
: "install brew" && {
  if ! command_exists brew; then
    info "installing brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
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
  packages=( node jq tree wget direnv vim git docker yarn nodenv cask starship fzf difftastic atuin )
  for package in ${packages[@]}; do
    if ! brew list | grep $package &> /dev/null; then
      info "installing ${package}..."
      arch -arm64 brew install ${package}
    else
      warn "${package} is already installed"
    fi
  done
  brew cleanup
}

info "==============setup node================"
: "install node by nodenv" && {
  if ! command_exists nodenv; then
    info "installing nodenv..."
    brew install nodenv
  fi
  info "install node latest version"
  # インストール済みの場合はインストールしない
  if ! nodenv versions | grep 22.14.0 &> /dev/null; then
    nodenv install 22.14.0
  fi
}

info "==============install brew cask================"
: "install brew cask" && {
  packages=( ghostty raycast google-japanese-ime \
  visual-studio-code karabiner-elements docker font-hack-nerd-font )
  for package in ${packages[@]}; do
    if ! brew list --cask | grep $package &> /dev/null; then
      if [ ${package} -eq font-hack-nerd-font ]; then
        # ref: https://yiskw713.hatenablog.com/entry/2021/06/20/143130
        info "installing font-hack-nerd-font..."
        brew tap homebrew/cask-fonts
        brew install --cask font-hack-nerd-font
        install_powerline
      fi
      info "installing ${package}..."
      brew install --cask ${package}
    else
      warn "${package} is already installed"
    fi
  done
}

info "==============setting vscode================"
: "setting vscode" && {
  info "create symbolic..."
  SCRIPT_DIR=$(cd $(dirname $0) && pwd)

  while read extension_name
  do
    echo `code --force --install-extension $extension_name`
  done < "./vscode/extensions.txt"

  VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
  rm -rf "$VSCODE_SETTING_DIR/settings.json"
  ln -s "$SCRIPT_DIR/vscode/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
}

ok "Complete!"
