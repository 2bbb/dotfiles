#!/bin/bash

set -e

NEED_COPY_LIST=(".npm-init.js")

IGNORE_LIST=("." ".." ".git" ".gitignore" "init.sh")

function is_ignored() {
    local i
    for i in ${IGNORE_LIST[@]}; do
        if [[ ${i} = ${1} ]]; then
            echo 1
            return
        fi
    done
    echo 0
}

function is_copy_needed() {
    local i
    for i in ${NEED_COPY_LIST[@]}; do
        if [[ ${i} = ${1} ]]; then
            echo 1
            return
        fi
    done
    echo 0
}

function symlink() {
    echo "* symlink \"$1\""
    if [ -f ${HOME}/$1 ]; then
        echo "  ${HOME}/$1 is exist [file]"
    elif [ -L ${HOME}/$1 ]; then
        echo "  ${HOME}/$1 is exist [symlink]"
    else
        echo "  symbloic link to ${HOME}/$1"
        ln -sf ${DOTFILES_DIR}/$1 ${HOME}/$1
    fi
}

function copyfile() {
    echo "* copy \"$1\""
    if [ -e ${HOME}/$1 ]; then
        echo "  ${HOME}/$1 is exist"
    else
        echo "  copyfile to ${HOME}/$1"
        cp ${DOTFILES_DIR}/$1 ${HOME}/$1
    fi
}

# goto dotfiles directory
cd $(dirname $0)

DOTFILES_DIR=`pwd`

for FILE in `ls -a ${DOTFILES_DIR}`
do
    if [ `is_ignored ${FILE}` = "0" ]
    then
        COPY_NEEDED=`is_copy_needed ${FILE}`
        if [ `is_copy_needed ${FILE}` = "1" ]
        then
            copyfile ${FILE}
        else
            symlink ${FILE}
        fi
    # else
    #     echo "* * ${FILE} is ignored"
    fi
done
