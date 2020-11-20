#!/bin/bash

PWD=$(pwd -P)

COMMANDS_LIST=('curl' 'wget' 'git' 'redshift' 'redshift-gtk' 'ffmpeg' 'gufw' 'ctags' 'tmux' 'xsel' 'clang-tools' 'clang-tidy' 'clang-format' 'ccache' 'gdb' 'autoconf' 'doxygen' 'gcc' 'g++' 'make' 'cmake')
NOT_FOUND=()
PACKAGES_LIST=('build-essential' 'python-pip' 'python3-dev' 'autotools-dev' 'libboost-all-dev' 'software-properties-common' 'openssh-client' 'imagemagick')
PIP_LIST=('cpplint' 'cppclean' 'pynvim' 'python-language-server' 'ipython')

## Goes $1 and does $2
## $1: directory to go
## $2: command to execute in dir
go_there_do_that() {
    echo "---------------------------------------BEGIN------------------------------------"
    echo ">>>$@>>>"
    echo "<<<>>>"
    cd $1; shift && $@
    echo "----------------------------------------END-------------------------------------"
}


## $1: message
log_this() {
    echo "*** $1 ***"
}

## $1: command
## $? 1: if not found
installed() {
    COMMAND_EXEC=$(command -v $1)
    if ! [ -x "$COMMAND_EXEC" ]; then
        echo "$1 is not installed!"
        return 1
    fi
}

## $1: user
## $2: repo
install_from_github() {
    log_this "Installing from GitHub: $1/$2"
    local latest_download_url=$(curl -s https://api.github.com/repos/$1/$2/releases/latest | awk -F '"' '/browser_download_url/{print $4}' | grep deb)
    local deb_name=$(basename $latest_download_url)
    log_this "Found: $deb_name"
    curl -LO $latest_download_url
    sudo dpkg -i $deb_name
}

### Check if package exist and install
## $1: package name
install_package() {
    PKG_AV=$(sudo apt-cache search $1)
    if [ -z "$PKG_AV" ]; then
        log_this "!!! Package $1 is not available for installation!"
        return
    fi
    PKG_OK=$({ dpkg-query -W --showformat='${Status}\n' $1|grep "install ok installed"; } 2>&1)
    if [ -z "$PKG_OK" ]; then
        log_this "Installing $1"
        sudo apt-get -qq install -y $1 > /dev/null
    else
        log_this "$1 already installed!"
    fi
}

## Pass given argument to apt
# $1: package name
install_with_apt() {
    log_this "Installing with apt: $1"
    sudo apt install $1
}

## Pass given argument to pip
# $1: package name
install_with_pip() {
    log_this "Installing with pip: $1"
    pip install --upgrade $1
}

tmux_plugins() {
    log_this "Installing plugin manager for tmux"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > /dev/null 2>&1
    log_this "Installing plugins"
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1
    tmux source ~/.tmux.conf
}

## FZF will be installed via VIM
# install_fzf() {
#     if ! installed fzf; then
#         git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#         ~/.fzf/install --no-zsh --no-fish
#     fi
# }

for c in "${COMMANDS_LIST[@]}"
do
    echo "Checking command $c..."
    if ! installed $c; then
        NOT_FOUND+=($c)
    fi
done

log_this "Could not found those commands, they will be installed:"
echo ${NOT_FOUND[@]}

for i in "${NOT_FOUND[@]}"
do
    go_there_do_that $PWD install_with_apt $i
done

log_this "Installing packages:"
echo ${PACKAGES_LIST[@]}
log_this "---"

for i in "${PACKAGES_LIST[@]}"
do
    go_there_do_that $PWD install_package $i
done

log_this "Installing PIP:"
echo ${PIP_LIST[@]}
log_this "---"

for i in "${PIP_LIST[@]}"
do
    go_there_do_that $PWD install_with_pip $i
done

# Install ripgrep
if ! installed rg; then
    install_from_github BurntSushi ripgrep
fi

# Install neovim from snap
if ! installed nvim; then
    log_this "sudo snap install nvim --classic"
    sudo snap install nvim --classic
fi

if ! installed npm; then
    curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh
    sudo bash nodesource_setup.sh
    sudo apt install nodejs
fi

tmux_plugins

