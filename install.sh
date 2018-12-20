#!/bin/bash

ln -sf $(pwd)/.bashrc ~/.bashrc
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.gitconfig ~/.gitconfig
ln -sf $(pwd)/.dircolors ~/.dircolors

if [ -e ~/.config/terminator ]; then
  ln -sf $(pwd)/terminator/config ~/.config/terminator/config
fi

