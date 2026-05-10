#!/bin/sh

CURRENT_DIR=$(pwd)
cd $HOME

# Helper function: Append line if it doesn't exist
append_if_missing() {
    LINE=$1
    FILE=$2
    touch "$FILE"
    if ! grep -Fxq "$LINE" "$FILE"; then
        echo "$LINE" >> "$FILE"
    fi
}

# Helper function: Create symlink only if it doesn't exist or points elsewhere
link_if_missing() {
    SRC=$1
    DEST=$2
    # Check if DEST is a symlink and if it already points to SRC
    if [ -L "$DEST" ] && [ "$(readlink "$DEST")" = "$SRC" ]; then
        return 0 # Already correctly linked
    else
        echo "Linking $DEST -> $SRC"
        ln -sf "$SRC" "$DEST"
    fi
}

# Set up bash configuration
append_if_missing "source $CURRENT_DIR/bash_profile" "$HOME/.bash_profile"
append_if_missing "source $CURRENT_DIR/bashrc" "$HOME/.bashrc"

# Setup TMUX
append_if_missing "source-file $CURRENT_DIR/tmux.conf" "$HOME/.tmux.conf"

# Configure Conky
link_if_missing "$CURRENT_DIR/conkyrc" "$HOME/.conkyrc"

# Set up Vim
append_if_missing "source $CURRENT_DIR/vimrc" "$HOME/.vimrc"
VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"

if [ ! -d "$VUNDLE_DIR" ]; then
    echo "Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR"
    link_if_missing "$CURRENT_DIR/plugins-vim" "$HOME/.vim/plugins-vim"
    vim -u ~/.vimrc -T dumb -n -i NONE -es -c "silent! PluginInstall" -c "qall" || true
fi

# ------ Terminal ----------

link_if_missing "$CURRENT_DIR/inputrc" "$HOME/.inputrc"
link_if_missing "$CURRENT_DIR/dir_colors" "$HOME/.dircolors"
link_if_missing "$CURRENT_DIR/takuya-powerline.omp.toml" "$HOME/.oh-my-posh.omp.toml"

# Alacritty logic
ALACRITTY_CONFIG_DIR=$HOME/.config/alacritty
ALACRITTY_CONFIG=$ALACRITTY_CONFIG_DIR/alacritty.toml
mkdir -p "$ALACRITTY_CONFIG_DIR"
touch "$ALACRITTY_CONFIG"

IMPORT_PATH="$CURRENT_DIR/alacritty/alacritty.toml"
if ! grep -q "$IMPORT_PATH" "$ALACRITTY_CONFIG"; then
    printf "[general]\nimport = [\"%s\"]\n\n" "$IMPORT_PATH" | cat - "$ALACRITTY_CONFIG" > temp.toml && mv temp.toml "$ALACRITTY_CONFIG"
fi

# Fontconfig (Linux only)
if [ "$(uname)" = "Linux" ]; then
    mkdir -p "$HOME/.config/fontconfig/conf.d"
    link_if_missing "$CURRENT_DIR/fontconfig/conf.d/99-terminus-fallback.conf" "$HOME/.config/fontconfig/conf.d/99-terminus-fallback.conf"
    fc-cache -fv
fi
