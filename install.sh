#!/bin/sh

CURRENT_DIR=$(pwd)
cd $HOME

echo "source $CURRENT_DIR/bash_profile" >> $HOME/.bash_profile

echo "source $CURRENT_DIR/bashrc" >> $HOME/.bashrc

ln -s $CURRENT_DIR/inputrc $HOME/.inputrc

echo "source-file $CURRENT_DIR/tmux.conf" >> $HOME/.tmux.conf

ln -s $CURRENT_DIR/conkyrc $HOME/.conkyrc

echo "source $CURRENT_DIR/vimrc" >> $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s $CURRENT_DIR/plugins-vim $HOME/.vim/plugins-vim
vim -u ~/.vimrc -T dumb -n -i NONE -es \
    -c "silent! PluginInstall" \
    -c "qall" || true

ln -s $CURRENT_DIR/tmux.conf $HOME/.tmux.conf

ln -s $CURRENT_DIR/dir_colors $HOME/.dircolors

ln -s $CURRENT_DIR/takuya-powerline.omp.json $HOME/.oh-my-posh.omp.json
