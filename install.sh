#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd "$(dirname "$0")"

ln .vimrc ~/.vimrc
ln .p10k.zsh ~/.p10k.zsh
