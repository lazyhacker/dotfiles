# This file is sourced on OSX from .bash_profile.
alias bd='popd >> /dev/null'

export HISTCONTROL=ignoredups:erasedups
export HISTIGNORE="&:[]*:exit:ls"
export EDITOR=vim

if [ -f $HOME/sdks/google-cloud-sdk/path.bash.inc ]; then
    # The next line updates PATH for the Google Cloud SDK.
    source $HOME/sdks/google-cloud-sdk/path.bash.inc
fi

if [ -f $HOME/sdks/google-cloud-sdk/completion.bash.inc ]; then
    # The next line enables bash completion for gcloud.
    source $HOME/sdks/google-cloud-sdk/completion.bash.inc
fi

if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    # Git completion
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi

if [ -f /usr/local/etc/bash_completion.d/tmux ]; then
    # Tmux completion
    source /usr/local/etc/bash_completion.d/tmux
fi

if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    # Shows git prompt when in a git repository
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
fi

# Powerline
#if [ -f /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
#    source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
#fi

# Set termcap for 256 color for VIM/SCREEN
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then
    export TERMCAP $(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')
fi

if [ $(uname) = 'Darwin' ]; then
    export LSCOLORS='fxFxcxdxbxegedabagacad'
    alias ls='ls -G'
    ############################################
    # Modified from emilis bash prompt script
    # from https://github.com/emilis/emilis-config/blob/master/.bash_ps1
    #
    # Modified for Mac OS X by
    # @corndogcomputer
    ###########################################
    # Fill with minuses
    # (this is recalculated every time the prompt is shown in function prompt_command):
    fill="—- "

    reset_style='\[\033[00m\]'
    status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
    prompt_style=$reset_style
    command_style=$reset_style'\[\033[1;29m\]' # bold black
    # Prompt variable:

    PS1="$status_style"'$fill \t\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}\u@\h:\w\$'"$command_style "

    # Reset color for command output
    # (this one is invoked every time before a command is executed):
    trap 'echo -ne "\033[00m"' DEBUG

    function prompt_command {

    # create a $fill of all screen width minus the time string and a space:
    let fillsize=${COLUMNS}-9
    fill=""
    while [ "$fillsize" -gt "0" ]
    do
    fill="-${fill}" # fill with underscores to work on
    let fillsize=${fillsize}-1
    done

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
    bname=`basename "${PWD/$HOME/~}"`
    echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
    ;;
    *)
    ;;
    esac

    }
    PROMPT_COMMAND=prompt_command
fi

if [ $(uname) = "Linux" ]; then
    # #### Put a seperator between prompt commands. ####
    # Fill with minuses (from: https://github.com/emilis/emilis-config/blob/master/.bash_ps1)
    # (this is recalculated every time the prompt is shown in function prompt_command):
    fill="--- "

    reset_style='\[\033[00m\]'
    if [ -z "$VIM" ];
    then status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
    else status_style=$reset_style'\[\033[0;90;107m\]'
    fi
    prompt_style=$reset_style
    command_style=$reset_style'\[\033[1;29m\]' # bold black
    # Prompt variable:

    OLD_PS1="$PS1"
    PS1="$status_style"'$fill \t\n'"$prompt_style$OLD_PS1$command_style"

    # Reset color for command output
    # (this one is invoked every time before a command is executed):
    trap 'echo -ne "\e[0m"' DEBUG


    function prompt_command {

        # create a $fill of all screen width minus the time string and a space:
        let fillsize=${COLUMNS}-9
        fill=""
        while [ "$fillsize" -gt "0" ]
        do
            fill="-${fill}" # fill with underscores to work on 
            let fillsize=${fillsize}-1
        done

        # If this is an xterm set the title to user@host:dir
        case "$TERM" in
        xterm*|rxvt*)
            bname=`basename "${PWD/$HOME/~}"`
            echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
            ;;
        *)
            ;;
        esac
    
    }
    PROMPT_COMMAND=prompt_command
    # #### End Seperator ####

    export LS_COLORS="no=00:fi=00:di=36:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"
    alias ls='ls --color=auto'
fi

if [ -f $HOME/.profile ]; then
    source $HOME/.profile
fi
