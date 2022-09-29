# !/bin/bash

    files="vimrc"

    for file in $files; do
        ln -s ~/dotfiles/$file ~/.$file
    done