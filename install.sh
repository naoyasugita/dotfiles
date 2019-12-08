DOTPATH=~/dotfiles

function command_exists() {
  type "$1" &> /dev/null ;
}

# if command_exists git; then
#     git clone "https://github.com/naoyasugita/dotfiles.git" "$DOTPATH"

if command_exists curl || command_exists wget; then
    tarball="https://github.com/naoyasugita/dotfiles/archive/master.tar.gz"

    if command_exists curl; then
        curl -L "$tarball"

    elif command_exists wget; then
        wget -O - "$tarball"

    fi | tar zxv
    SCRIPT_DIR=$(cd $(dirname $0) && pwd)
    mkdir ~/dotfiles
    mv -i "$SCRIPT_DIR/dotfiles-master/*" "$DOTPATH"
    rm -rf "$SCRIPT_DIR/dotfiles-master"
else
    echo "curl or wget required"
fi

cd ~/dotfiles
if [ $? -ne 0 ]; then
    echo "not found: $DOTPATH"
else
    sh deploy.sh
    sh setup.sh
fi
