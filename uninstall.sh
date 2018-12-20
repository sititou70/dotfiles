#!/bin/bash

rm -rf ~/.bashrc
rm -rf ~/.zshrc
rm -rf ~/.vimrc
rm -rf ~/.gitconfig
rm -rf ~/.dircolors

if [ -e ~/.config/terminator ]; then
  rm -rf ~/.config/terminator/config
fi

