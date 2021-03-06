#!/bin/bash

ROOT=$(pwd)
BACKUP_FOLDER="$HOME/dotfilesBackup/$(date +%F_%H_%M)"
mkdir -p $BACKUP_FOLDER

##
# Creates backup if the file exists. Then creates symlink to source file.
#  $1: source file
#  $2: place to create link
##
createLink() {
    echo "--------------------------------"
    echo "File in progress: $2"
    if [ -e $2 ]; then
        echo "Backup under $BACKUP_FOLDER: $2"
        mv $2 $2.BAK
        mv $2.BAK $BACKUP_FOLDER
    fi
    echo "Linking: $1 -> $2"
    ln -s $1 $2
    echo "--------------------------------"
}

installPowerlineFont() {
    echo "--------------------------------"
    echo "Installing powerline font..."
    # clone
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
    echo "--------------------------------"
}

### Settings for c++
createLink $ROOT/.clang-format $HOME/.clang-format

### Settings for nvim
mkdir -p $HOME/.config/nvim
createLink $ROOT/nvim/init.vim $HOME/.config/nvim/init.vim
createLink $ROOT/nvim/.ycm_extra_conf.py $HOME/.config/nvim/.ycm_extra_conf.py
ln -s $ROOT/nvim/templates $HOME/.config/nvim/templates
ln -s $ROOT/nvim/tags $HOME/.config/nvim/tags
installPowerlineFont
nvim +'PlugInstall --sync' +qa
cd $HOME/.config/nvim/plugged/YouCompleteMe && ./install.py

### Settings for redshift
createLink $ROOT/config/redshift.conf $HOME/.config/redshift.conf

### Settings for bash
createLink $ROOT/shell/.bashrc $HOME/.bashrc
createLink $ROOT/shell/.bash_functions $HOME/.bash_functions
createLink $ROOT/shell/.bash_aliases $HOME/.bash_aliases
createLink $ROOT/shell/.tmux.conf $HOME/.tmux.conf
tmux source ~/.tmux.conf

# Reload bash
read -n 1 -s -r -p "Press any key to reload bash"
source ~/.bashrc

