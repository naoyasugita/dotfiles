### git ###
# git checkout branchをfzfで選択
alias gc='git checkout $(git branch -a | tr -d " " |fzf --height 100% --prompt "CHECKOUT BRANCH>" --preview "git log --color=always {}" | head -n 1 | sed -e "s/^\*\s*//g" | perl -pe "s/remotes\/origin\///g")'
# 現在のブランチをoriginにpushする
alias gps='git push origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
# 現在のブランチをpullする
alias gpl='git pull --rebase origin $(git branch | grep "*" | sed -e "s/^\*\s*//g")'
alias gs='git status -s'
alias gd='git diff -b'
alias gf='git fetch -p'

### other ###
# google検索
alias goo='searchByGoogle'
function searchByGoogle() {
    # 第一引数がない場合はpbpasteの中身を検索単語とする
    [ -z "$1" ] && searchWord=`pbpaste` || searchWord=$1
    open https://www.google.co.jp/search\?q\=$searchWord
}
