#!/bin/bash

cd $HOME

# Update packages
sudo add-apt-repository ppa:jonathonf/vim
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install vim vim-gtk3 git wget curl

# setup Bash shell
wget -O $HOME/.bashrc https://raw.githubusercontent.com/huyvn/dotfiles/master/bashrc

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
echo 'export GOPATH=$HOME/code/go' >> $HOME/.profile
echo 'export GOBIN=$HOME/code/go/bin' >> $HOME/.profile
echo 'export PATH=$PATH:/usr/local/go/bin:/$GOBIN' >> $HOME/.profile

rm -f go1.10.1.linux-amd64.tar.gz

# Python
echo 'export ML_PATH=$HOME/code/python/ml'

#######
# VIM #
#######

# get vim config
mkdir -p $HOME/.vim
wget -O $HOME/.vimrc https://raw.githubusercontent.com/huyvn/dotfiles/master/vimrc
wget -O $HOME/.vim/plug.vim https://github.com/huyvn/dotfiles/raw/master/vim/plug.vim

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


########
# POST #
########

source $HOME/.bashrc
source $HOME/.profile