export ZSH="$HOME/.oh-my-zsh"
export CLICOLOR=true
export LANG=ja_JP.UTF-8
export GIT_EDITOR=vim
export EDITOR=vim

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# direnv
eval "$(direnv hook zsh)"

# flutter
export PATH="$PATH:$HOME/dotfiles/flutter/bin"

# Androiid SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"
