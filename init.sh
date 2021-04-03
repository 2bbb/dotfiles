#!/bin/bash

set -e

function symlink() {
    echo symlink \"$1\"
    if [ -f ${HOME}/$1 ]; then
        echo "  ${HOME}/$1 is exist [file]"
    elif [ -L ${HOME}/$1 ]; then
        echo "  ${HOME}/$1 is exist [symlink]"
    else
        echo "  symbloic link to ${HOME}/$1"
        # ln -sf ${DOTFILES_DIR}/$1 ${HOME}/$1
    fi
}

function copyfile() {
    echo copy \"$1\"
    if [ -e ${HOME}/$1 ]; then
        echo "  ${HOME}/$1 is exist"
    else
        echo "  symbloic link to ${HOME}/$1"
        # cp ${DOTFILES_DIR}/$1 ${HOME}/$1
    fi
}

# goto dotfiles directory
cd $(dirname $0)

DOTFILES_DIR=`pwd`

symlink .vimrc
symlink Brewfile
copyfile .npm-init.js

