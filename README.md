My common dot files for OSX and Linux.

Simply symlink to these (e.g. ln -s bashrc ~/.bashrc).

vimrc uses VUNDLE to manage plug-ins and after installing YouCompleteMe needs to be compiled.

To disable certain plugins locally:

  set runtimepath-=~/.vim/bundle/<plugin dir>

To unset any settings:  unlet g:<variable>
