#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ABS_PATH="$(pwd)/$(dirname "$0")"

ln -s "$ABS_PATH/.vimrc" ~/.vimrc
ln -s "$ABS_PATH/.p10k.zsh" ~/.p10k.zsh
