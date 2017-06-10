My common dot files for OSX and Linux.

Install
-------

```
$ git clone https://github.com/lazyhacker/dotfiles
```

VIM
---

Install VUNDLE:

```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

In ~/.vimrc, add to the beginning:

```vim
source dotfiles/vimrc 
```

To disable certain plugins locally:

```vim
set runtimepath-=~/.vim/bundle/<plugin dir>
```

To unset any settings:

```vim
unlet g:<variable>
```

BASH
----

Add to the start of ~/.bashrc

```bash
source dotfiles/bashrc
```

Symlink bash_profile to .bash_profile:

```bash
$ ln -s dotfiles/bashrc ~/.bashrc
```

TMUX
----

```
$ ln -s dotfiles/tmux.conf ~/.tmux.conf
```

Conky
-----

```
$ ln -s dotfiles/conkyrc ~/.conkrc
```

Xmodmap
-------

```
$ ln -s dotfiles/Xmodmap ~/.Xmodmap
```
