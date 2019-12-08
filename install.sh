DOTPATH=~/dotfiles

function command_exists() {
  type "$1" &> /dev/null ;
}

: "install dotfiles" && {
  if command_exists git; then
    git clone "https://github.com/naoyasugita/dotfiles.git" "$DOTPATH"

  elif command_exists curl || command_exists wget; then
    tarball="https://github.com/naoyasugita/dotfiles/archive/master.tar.gz"

    if command_exists curl; then
        curl -L "$tarball"

    elif command_exists wget; then
        wget -O - "$tarball"

    fi | tar zxv -C ~/
    mkdir -p ~/dotfiles
    mv -i ~/dotfiles-master/* "$DOTPATH" $$ rm -rf ~/dotfiles-master
  else
    echo "curl or wget required"
  fi
}

: "deploy and setup" && {
  cd ~/dotfiles
  if [ $? -ne 0 ]; then
    echo "not found: $DOTPATH"
  else
    sh deploy.sh
    sh setup.sh
  fi
}
