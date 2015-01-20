# This file is sourced on OSX from .bash_profile.
alias ls='ls -G'
alias bd='popd >> /dev/null'
alias dualview='$HOME/bin/syn2animedia.sh'

export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="&:[]*:exit:ls"
export EDITOR=vim

# The next line updates PATH for the Google Cloud SDK.
source $HOME/sdks/google-cloud-sdk/path.bash.inc
# The next line enables bash completion for gcloud.
source $HOME/sdks/google-cloud-sdk/completion.bash.inc
# Git completion
source /usr/local/etc/bash_completion.d/git-completion.bash
# Tmux completion
source /usr/local/etc/bash_completion.d/tmux
# Shows git prompt when in a git repository
source /usr/local/etc/bash_completion.d/git-prompt.sh

PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

# Powerline
#if [ -f /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
#    source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
#fi

# Set termcap for 256 color for VIM/SCREEN
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then
    export TERMCAP $(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')
fi
export LSCOLORS='fxFxcxdxbxegedabagacad'

# Set things up for Go
export GOROOT=/usr/local/go
export GOPATH=$HOME/workspace

export PATH=$PATH:$HOME/sdks/go_appengine:$HOME/workspace/bin
