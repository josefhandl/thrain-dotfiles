#!/bin/bash

change_shell_failed () {
	echo "Changing the default shell failed. You have to change it manually and start this script again"
	exit 2
}

if [ ! -e "/bin/zsh" ]; then
	echo "Install zsh and start this script again"
	exit 1
fi

## Try to change the default shell to the zsh
#chsh -s /bin/zsh || change_shell_failed

sleep 1

## Check if the zsh is set as a default shell
#if [ "/bin/zsh" != $(cat /etc/passwd | grep $USER | cut -d":" -f7) ]; then
#	change_shell
#fi

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ABS_PATH="$(pwd)/$(dirname "$0")"

ln -s "$ABS_PATH/terminal/.vimrc" ~/.vimrc
ln -s "$ABS_PATH/terminal/.p10k.zsh" ~/.p10k.zsh
ln -s "$ABS_PATH/terminal/ssh-config" ~/.ssh/config

rm ~/.zshrc
ln -s "$ABS_PATH/terminal/.zshrc" ~/.zshrc

# Install vim plugins
vim +'PlugUpdate --sync' +qa

# Install K9s
curl -sS https://webinstall.dev/k9s | bash
