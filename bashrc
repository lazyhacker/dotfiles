# If not running interactively then don't do anything further.
[[ $- == *i* ]] || return

# If not running interactively then don't do anything further.
[ -z "$PS1" ] && return

alias bd='popd >> /dev/null'
alias cd='cd -P'
alias ls='ls --color=auto'

export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="&:[]*:exit:ls"
export EDITOR=vim

# check the window size after each command and if necessary
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Set termcap for 256 color for VIM/SCREEN
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then
    export TERMCAP $(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"
   
# Check if the script exists, then source it
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
elif [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
fi

if [ -f "$HOME/.ssh/environment" ]; then 
    SSH_ENV="$HOME/.ssh/environment"

    function start_agent {
        echo "Initialising new SSH agent..."
        /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
        echo succeeded
        chmod 600 "${SSH_ENV}"
        . "${SSH_ENV}" > /dev/null
        /usr/bin/ssh-add;
    }
fi

# Source SSH settings, if applicable

#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    #ps ${SSH_AGENT_PID} doesn't work under cywgin
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi

# Tell CMake to use Ninja to build
if [ -f /usr/bin/ninja ]; then
    export CMAKE_GENERATOR=Ninja
    #export CMAKE_MAKE_PROGRAM=/usr/bin/ninja
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    bname=`basename "${PWD/$HOME/~}"`
    echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
    ;;
*)
;;
esac

if command -v dircolors >/dev/null 2>&1; then
    eval $(dircolors $HOME/.dircolors)

fi

# Map common VIM commands to the command line.
command_not_found_handle() {
    if [[ $1 == :* ]]; then
        # Remove the leading colon
        local cmd="${1#:}"

        # Map specific vim commands to tmux commands
        case "$cmd" in
            q)  exit ;;
            qa) tmux kill-session ;;
            vs) tmux split-window -h ;;
            sp) tmux split-window -v ;;
            bn) tmux next-window ;;
            bp) tmux previous-window ;;

            *)  echo "Vim habit detected, but no tmux mapping for: $cmd" ;;
        esac
    else
        # Standard error if it's not a :command
        echo "bash: $1: command not found"
        return 127
    fi
}

#if command -v powerline-daemon > /dev/null 2>&1; then
#  powerline-daemon -q
#  POWERLINE_BASH_CONTINUATION=1
#  POWERLINE_BASH_SELECT=1
#  if [ -f /usr/share/powerline/bash/powerline.sh ]; then
#    . /usr/share/powerline/bash/powerline.sh
#  fi
#  if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
#    . /usr/share/powerline/bindings/bash/powerline.sh
#  fi
#fi

# --------------------------------------------------------
# Customize the command prompt.
# --------------------------------------------------------

# Set prompt styling.
reset_style='\[\033[00m\]'
#status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
status_style=$reset_style'\[\033[0;29m\]' # gray color; use 0;37m for lighter color
prompt_style=$reset_style
command_style=$reset_style'\[\033[1;29m\]' # bold black

# Call the Git prompt function to build the actual PS1
# This will now include the Git branch AND your line
export GIT_PS1_SHOWDIRTYSTATE=1 # Shows * for unstaged changes)
export GIT_PS1_SHOWUNTRACKEDFILES=1 # Shows % for new files)
export GIT_PS1_SHOWUPSTREAM="auto" # Shows if you are ahead/behind your origin)

# Reset color for command output
# (this one is invoked every time before a command is executed):
trap 'echo -ne "\e[0m"' DEBUG

# Create a custom prompt
function prompt_command {
    # #### Put a seperator between prompt commands. ####
    # Fill with minuses (from: https://github.com/emilis/emilis-config/blob/master/.bash_ps1)
    # (this is recalculated every time the prompt is shown in function prompt_command):
    #
    # Create a $fill of all screen width minus the time string and a space:
    let fillsize=${COLUMNS}-9
    fill=""
    while [ "$fillsize" -gt "0" ]
    do
        fill="-${fill}" # fill with underscores to work on 
        let fillsize=${fillsize}-1
    done

    if type __git_ps1 &>/dev/null; then
        # Use Git-aware prompt
        __git_ps1 "$status_style$fill \t\n$prompt_style\u@\h:\w" "$command_style\\\$ "
    else
        PS1="$prompt_style\u@\h:\w$command_style\\\$ "
    fi
}

# Use oh-my-posh as default if available
if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init bash --config ~/.oh-my-posh.omp.toml)"
else
    PROMPT_COMMAND=prompt_command
fi

# Overrides for Darwin/MacOS
if [ $(uname) = 'Darwin' ]; then
    export LSCOLORS='fxFxcxdxbxegedabagacad'
    alias ls='ls -G'
fi


# 1. Check if we are in an interactive shell
# 2. Check if we are in an SSH session
# 3. Check that we aren't ALREADY inside tmux
# Note: if this breaks then use this to start an plain shell:
#    ssh user@remote-host /bin/bash --norc
if [[ $- == *i* && -n "$SSH_CONNECTION" && -z "$TMUX" ]]; then
    exec tmux new-session -A -s main
fi

