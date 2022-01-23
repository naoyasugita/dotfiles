#!/bin/bash
set -euo pipefail

source lib/echos.sh

readonly DOT_FILES=( .zshrc .zsh.d .vimrc .config)

for file in ${DOT_FILES[@]}; do
  dest=${HOME}/${file}
  if [ $file = ".config" ]; then
    if [ -e ${dest}/starship.toml ]; then
      ok "[update] ${dest}/starship.toml: (already exists)"
    else
      ln -s $HOME/dotfiles/$file/starship.toml ${HOME}/${file}/starship.toml
      ok "[create] ${dest}"
    fi
  elif [ -e ${dest} ]; then
    ok "[update] ${dest}: (already exists)"
  else
    ln -s $HOME/dotfiles/$file $dest
    ok "[create] ${dest}"
  fi
done

ok "Complete!"
