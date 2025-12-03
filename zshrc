# ~/.zshrc (Ported from .bashrc)

# Aliases (These are compatible with Zsh)
alias bd='popd >> /dev/null'
alias cd='cd -P'

# History
# Zsh uses setopt and different variable names for history
# 'ignoredups:erasedups' is best translated as HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_ALL_DUPS
# 'HISTIGNORE="&:[]*:exit:ls"' translates to:
# '&' is covered by HIST_IGNORE_ALL_DUPS
# The rest are added to the HIST_IGNORE array
HIST_IGNORE=('ls' 'exit' '\[ *')

# Editor (Compatible with Zsh)
export EDITOR=vim

# If not running interactively then don't do anything further.
# This is the standard Zsh way to check for an interactive shell.
[[ -o interactive ]] || return

# 'shopt -s checkwinsize' is not needed; Zsh handles this by default.

# make less more friendly for non-text input files, see lesspipe(1)
# (Compatible with Zsh)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Zsh Native Completion
# Zsh has its own powerful completion system.
# Sourcing bash completions is generally not recommended.
# This block enables Zsh's completion system, which should
# automatically find completions for git, tmux, etc.
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# Powerline
# Use 'command -v' instead of 'which' for better portability.
if command -v powerline-daemon >/dev/null 2>&1; then
  powerline-daemon -q
  # NOTE: POWERLINE_BASH_* variables are for Bash only.
  # We look for the Zsh-specific binding files instead.
  if [ -f /usr/share/powerline/zsh/powerline.zsh ]; then
    . /usr/share/powerline/zsh/powerline.zsh
  fi
  if [ -f /usr/share/powerline/bindings/zsh/powerline.zsh ]; then
    . /usr/share/powerline/bindings/zsh/powerline.zsh
  fi
fi

# Set termcap for 256 color for VIM/SCREEN
# (Compatible with Zsh)
if [ ! -z "$TERMCAP" ] && [ "$TERM" == "screen" ]; then
    export TERMCAP $(echo $TERMCAP | sed -e 's/Co#8/Co#256/g')
fi


# --- OS-Specific Settings ---
# We must enable PROMPT_SUBST for the $fill variable to be expanded
setopt PROMPT_SUBST

if [ $(uname) = 'Darwin' ]; then
    export LSCOLORS='fxFxcxdxbxegedabagacad'
    alias ls='ls -G'
    # Zsh uses PROMPT. Use %* for HH:MM:SS (to match Bash \t)
    PROMPT="$status_style"'$fill %*'$'\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}%n@%m:%~%# '"$command_style"

    # Zsh's equivalent of 'trap ... DEBUG' is the 'preexec' function
    preexec() {
        echo -ne "\e[00m"
    }

    # Zsh's equivalent of 'PROMPT_COMMAND' is the 'precmd' function
    precmd() {
        # Zsh uses ((...)) for arithmetic
        (( fillsize = COLUMNS - 9 ))
        fill=""
        while (( fillsize > 0 )); do
            fill="-${fill}"
            (( fillsize-- ))
        done

        # Set xterm title (uses $HOST instead of $HOSTNAME for Zsh)
        case "$TERM" in
        xterm*|rxvt*)
            bname=`basename "${PWD/$HOME/~}"`
            echo -ne "\033]0;${bname}: ${USER}@${HOST}: ${PWD/$HOME/~}\007"
            ;;
        *)
            ;;
        esac
    }
fi

if [ $(uname) = "Linux" ]; then
    ############################################
    # Zsh Prompt Port (Linux)
    ###########################################

    # Zsh requires prompt escape codes to be wrapped in %{...%}
    fill="--- "
    reset_style='%{\e[00m%}'
    status_style=$reset_style'%{\e[0;29m%}' # gray color
    prompt_style=$reset_style
    command_style=$reset_style'%{\e[1;29m%}' # bold black

    # Zsh uses PROMPT (or PS1). Prompt codes are different (see Mac)
    PROMPT="$status_style"'$fill %T\n'"$prompt_style"'${debian_chroot:+($debian_chroot)}%n@%m:%~%# '"$command_style"

    # Zsh's equivalent of 'trap ... DEBUG' is the 'preexec' function
    preexec() {
        echo -ne "\e[0m"
    }

    # Zsh's equivalent of 'PROMPT_COMMAND' is the 'precmd' function
    precmd() {
        # Zsh uses ((...)) for arithmetic, not 'let'
        (( fillsize = COLUMNS - 9 ))
        fill=""
        while [ "$fillsize" -gt "0" ]; do
            fill="-${fill}"
            (( fillsize-- ))
        done

        # Set xterm title (uses $HOST instead of $HOSTNAME for Zsh)
        case "$TERM" in
        xterm*|rxvt*)
            bname=`basename "${PWD/$HOME/~}"`
            echo -ne "\033]0;${bname}: ${USER}@${HOST}: ${PWD/$HOME/~}\007"
            ;;
        *)
            ;;
        esac
    }

    # (Compatible with Zsh)
    test -r "$HOME/.dircolors" && eval $(dircolors $HOME/.dircolors)
    alias ls='ls --color=auto'
fi

# --- SSH Agent ---
# This shell function is compatible with Zsh.
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
# (This logic is compatible with Zsh, kept commented as in original)
#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi

# Tell CMake to use Ninja to build
# (Compatible with Zsh)
if [ -f /usr/bin/ninja ]; then
    export CMAKE_GENERATOR=Ninja
fi

export PATH=/usr/local/go/bin:$HOME/go/bin:$PATH

. "$HOME/.local/bin/env"
