#!/bin/bash

cd $HOME

# Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt -y install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Vim 8
sudo add-apt-repository -y ppa:jonathonf/vim

# Timeshift
sudo add-apt-repository -y ppa:teejee2008/ppa

# BackInTime
sudo add-apt-repository -y ppa:bit-team/stable

# Update packages
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install git wget curl vim vim-gtk3 sublime-text firefox tmux gparted
sudo apt -y install timeshift backintime-qt4 psensor

# setup Bash shell
wget -O $HOME/.bashrc https://gitlab.com/huyvng/dotfiles/raw/master/bashrc

# setup home
mkdir -p $HOME/code/{go,python,js,rust}
mkdir -p $HOME/code/python/ml

########################
# Programming Language #
########################

# Rust
wget -O $HOME/rustup.sh https://sh.rustup.rs
chmod +x $HOME/rustup.sh
$HOME/rustup.sh -y
source $HOME/.cargo/env

rm -f $HOME/rustup.sh

# Go
wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.10.1.linux-amd64.tar.gz
echo 'export GOPATH=$HOME/code/go' >> $HOME/.bashrc.local
echo 'export GOBIN=$HOME/code/go/bin' >> $HOME/.bashrc.local
echo 'export PATH=$PATH:/usr/local/go/bin:/$GOBIN' >> $HOME/.bashrc.local

rm -f go1.10.1.linux-amd64.tar.gz

# Python
echo 'export ML_PATH=$HOME/code/python/ml' >> $HOME/.bashrc.local

########
# tmux #
########

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
wget -O $HOME/.tmux.conf https://gitlab.com/huyvng/dotfiles/raw/master/tmux.conf

#######
# VIM #
#######

# get vim config
mkdir -p $HOME/.vim
wget -O $HOME/.vimrc https://gitlab.com/huyvng/dotfiles/raw/master/vimrc
wget -O $HOME/.vim/plug.vim https://gitlab.com/huyvng/dotfiles/raw/master/vim/plug.vim

# setup VimPlug and Vim directory
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p $HOME/.vim/swapdir
mkdir -p $HOME/.vim/backupdir
mkdir -p $HOME/.vim/undodir

# install ripgrep
# if Ubuntu
# sudo snap install rg
cargo install ripgrep

# install Vim plugins
vim +PlugInstall +qall

###############
# Sublime Text#
###############

# Install Package Control
mkdir -p $HOME/.config/sublime-text-3/Installed\ Packages
wget -O $HOME/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package https://packagecontrol.io/Package%20Control.sublime-package

# get settings
mkdir -p $HOME/.config/sublime-text-3/Packages/User
wget -O $HOME/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings https://gitlab.com/huyvng/dotfiles/raw/master/sublimetext/Package%20Control.sublime-settings
wget -O $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings https://gitlab.com/huyvng/dotfiles/raw/master/sublimetext/Preferences.sublime-settings

########
# POST #
########

echo "Please reboot your machine to complete installation."
echo
echo "Else please run below command before using shell."
echo -e "\t source ~/.bashrc.local"
echo -e "\t tmux source ~/.tmux.conf\n"

echo -e "For Sublime Text, on first startup please allow time to install all packages. Press Ctrl+\` to view process."
