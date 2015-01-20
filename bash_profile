# On OSX the order is /etc/profile the the first one of the following:
#   ~/.bash_profile
#   ~/.bash_login
#   ~/.profile
#
# OSX Terminal.app does not load .bashrc because each terminal is considered
# a new login shell and .bashrc is for interactive non-login shells.

if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
