#!/bin/bash

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ABS_PATH="$(pwd)/$(dirname "$0")"

ln -s "$ABS_PATH/.vimrc" ~/.vimrc
ln -s "$ABS_PATH/.p10k.zsh" ~/.p10k.zsh
