#!/bin/sh

CURRENT_DIR=$(pwd)
cd $HOME

# Set up bash configuration
echo "source $CURRENT_DIR/bash_profile" >> $HOME/.bash_profile
echo "source $CURRENT_DIR/bashrc" >> $HOME/.bashrc

# Setup TMUX
echo "source-file $CURRENT_DIR/tmux.conf" >> $HOME/.tmux.conf
#ln -s $CURRENT_DIR/tmux.conf $HOME/.tmux.conf

# Configure Conky
ln -s $CURRENT_DIR/conkyrc $HOME/.conkyrc

# Set up Vim and install the plugins.
echo "source $CURRENT_DIR/vimrc" >> $HOME/.vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s $CURRENT_DIR/plugins-vim $HOME/.vim/plugins-vim
vim -u ~/.vimrc -T dumb -n -i NONE -es \
    -c "silent! PluginInstall" \
    -c "qall" || true

# ------ Terminal ----------

# Configure keybindings for Readline in the terminal
ln -s $CURRENT_DIR/inputrc $HOME/.inputrc

# Colorize the file system.
ln -s $CURRENT_DIR/dir_colors $HOME/.dircolors

# Configure the prompt
ln -s $CURRENT_DIR/takuya-powerline.omp.toml $HOME/.oh-my-posh.omp.toml
#oh-my-posh config export --config $CURRENT_DIR/takuya-powerline.omp.json --format toml > $HOME/.oh-my-posh.omp.toml

# Configure Alacritty terminal
echo "import = [\"$CURRENT_DIR/alacritty.toml\"]" | cat - $HOME/.config/alacritty/alacritty.toml > temp.toml && mv temp.toml ~/.config/alacritty/alacritty.toml

# Set up fallback fonts for symbols in Terminus.
# This assumes that the font being used is Terminus and the fallback is
# Cascadia Mono nerd font.
mkdir -p $HOME/.config/fontconfig/conf.d
ln -s $CURRENT_DIR/fontconfig/conf.d/99-terminus-fallback.conf $HOME/.config/fontconfig/conf.d
fc-cache -fv
