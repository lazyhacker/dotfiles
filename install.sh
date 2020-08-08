#!/bin/sh

cd $HOME

echo "source $HOME/dotfiles/bash_profile" >> $HOME/.bash_profile

echo "source $HOME/dotfiles/bashrc" >> $HOME/.bashrc

ln -s $HOME/dotfiles/conkyrc $HOME/.conkyrc

echo "source $HOME/dotfiles/vimrc" >> $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

ln -s $HOME/dotfiles/tmux.conf $HOME/.tmux.conf

ln -s $HOME/dotfiles/dir_colors $HOME/.dircolors
