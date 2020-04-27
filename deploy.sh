#!/bin/bash
set -euo pipefail

source lib/echos.sh

readonly DOT_FILES=( .zshrc .zsh.d .vimrc)

for file in ${DOT_FILES[@]}; do
  dest=${HOME}/${file}
  if [ -e ${dest} ]; then
    ok "[update] ${dest}: (already exists)"
  else
    ln -s $HOME/dotfiles/$file $dest
    ok "[create] ${dest}"
  fi
done

ok "Complete!"
