#!/bin/bash

change_shell () {
	echo "Changing the default shell failed. You have to change it manually and start this script again"
	exit 2
}

if [ ! -e "/bin/zsh" ]; then
	echo "Install zsh and start this script again"
	exit 1
fi

chsh -s /bin/zsh || change_shell

sleep 1

if [ "/bin/zsh" != $(cat /etc/passwd | grep $USER | cut -d":" -f7) ]; then
	change_shell
fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ABS_PATH="$(pwd)/$(dirname "$0")"

ln -s "$ABS_PATH/.vimrc" ~/.vimrc
ln -s "$ABS_PATH/.p10k.zsh" ~/.p10k.zsh

rm ~/.zshrc
ln -s "$ABS_PATH/.zshrc" ~/.zshrc
