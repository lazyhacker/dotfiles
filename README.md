My common dot files for OSX and Linux.

Install
-------

```
$ git clone https://github.com/lazyhacker/dotfiles
```

VIM
---


In `~/.vimrc` (Linux/OSX) or `~/_vimrc` (Windows), add to the beginning:

```vim
source dotfiles/vimrc
```

Install VUNDLE:

```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
To disable certain plugins locally:

```vim
set runtimepath-=~/.vim/bundle/<plugin dir>
```

To unset any settings:

```vim
unlet g:<variable>
```

To install local-only plugins, in your .vimrc you'll need to add

```
call vundle#begin()
"Comment out if you want the checked-in list as well
"source ~/.vim/plugins-vim

Plugin "plugin-to-install"
...

call vundle#end()

```

BASH
----

## Loading Order
The loading order of Bash startup files is first dependent on the type of
shell that Bash think it is in.

A **Login shell** is when the user logs in from tty (not through a GUI) or logs
in remotely (e.g. through ssh).

A **Non-login shell** is started in other ways such as gnome-terminal which
is started by Gnome (it is a login shell that launched Gnome).

Note: The exception is OSX's Terminal.app which is treated as a login shell.

For non-login shells (e.g. gnome-terminal) the order is:

```
   /etc/bash.bashrc
   ~/.bashrc
```

For login-shells (including Terminal.app) the order is:
  `/etc/profile` and then first of:

```
     ~/.bash_profile
     ~/.bash_login
     ~/.profile
```

## Install

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
