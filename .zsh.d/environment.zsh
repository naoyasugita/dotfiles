# starship
eval "$(starship init zsh)"

export CLICOLOR=true
export LANG=ja_JP.UTF-8
export GIT_EDITOR=vim
export EDITOR=vim

# bat
export BAT_PAGER="less -RF"

# nodenv
eval "$(nodenv init -)"

# direnv
eval "$(direnv hook zsh)"

# flutter
export PATH="$HOME/fvm/default/bin:$PATH"
export PATH="$HOME/.pub-cache/bin:$PATH"

# Androiid SDK
export ANDROID_HOME="$HOME/Library/Android/sdk"

# nodebrew
export PATH="$PATH:$HOME/.nodebrew/current/bin"

# pipr
# https://crates.io/crates/pipr
export PATH="$PATH:$HOME/.cargo/bin"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
