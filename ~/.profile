######################
#  DUzun's .profile  #
#  @version 2.1.2    #
######################


# Set user-defined locale
# export LANG=$(locale -uU)

###############################################################################
# Shell behavior                                                              #
###############################################################################

# Increase the history file size and set some sane defaults
export HISTSIZE=20000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTCONTROL=ignorespace # Don't store commands beginning with a space


function bash_prompt() {
    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local BK="\[\033[1;30m\]"
    local BR="\[\033[1;31m\]"
    local BG="\[\033[1;32m\]"
    local BY="\[\033[1;33m\]"
    local BB="\[\033[1;34m\]"
    local BM="\[\033[1;35m\]"
    local BC="\[\033[1;36m\]"
    local BW="\[\033[1;37m\]"

    # reset
    local RESET="\[\033[0;37m\]"

    # curl -L -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

    GIT_PROMPT_ONLY_IN_REPO=1
    if [ -f /usr/share/git/git-prompt.sh ]; then
        . /usr/share/git/git-prompt.sh
    elif [ -f ~/.git-prompt.sh ]; then
        . ~/.git-prompt.sh
    elif [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
        . ~/.bash-git-prompt/gitprompt.sh
    fi

    # If the git completion function exists, then use its built-in command prompt
    if command -v __git_ps1 > /dev/null; then
        export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h\[\033[36m\]`__git_ps1`\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n> ';
    else
        export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n> ';
    fi
}

# ------------------------------------------------------------------------------
# If running interactively, set PS1
[[ "$-" == *i* ]] && [ -n "$BASH" ] && bash_prompt;

if command -v shopt > /dev/null; then
    # in zsh there is `setopt`, but we preffer default for zsh

    # Check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # Append all commands to the history file; don't overwrite it at the start of every new session
    shopt -s histappend
fi

# ------------------------------------------------------------------------------
# Add to path npm's bin folder
function npmbin() {
    local npmbin;
    npmbin=${PWD:-$(pwd)}/node_modules/.bin;
    [ -d "$npmbin" ] && PATH=$npmbin:$PATH && echo "$npmbin";
    return $?;
}

# Add to path composer's bin folder
function composerbin() {
    local composerbin;
    composerbin=${PWD:-$(pwd)}/vendor/bin;
    [ -d "$composerbin" ] && PATH=$composerbin:$PATH && echo "$composerbin";
    return $?;
}

# ------------------------------------------------------------------------------
if ! command -v realpath; then
    _p=$(dirname "${BASH_SOURCE:-$0}")
    _r="$_p/../src/realpath"
    [ -x "$_r/realpath" ] || ( cd "$_r" && make > /dev/null ) && alias realpath="$("$_r/realpath" "$_r/realpath")"
    # ln -s "$_r/realpath" /usr/local/bin/realpath
fi

# ------------------------------------------------------------------------------
# echo .: ${BASH_SOURCE[@]}
# if [ -z "$BASH_SOURCE" ]; then local BASH_SOURCE=$_; fi

_profile=$(realpath "${BASH_SOURCE:-$0}")
_dotfiles=$(dirname "$_profile")

[ -f "$_dotfiles/.aliasrc" ] && . "$_dotfiles/.aliasrc";

# Load OS speciffic .profile
[ -n "$_os" ] && [ -f "$_profile.$_os" ] && . "$_profile.$_os";
# ------------------------------------------------------------------------------

export NVM_DIR=~/.nvm
if [ -s "$NVM_DIR/nvm.sh" ]; then

    # This loads nvm
    . "$NVM_DIR/nvm.sh"

    # When there is no node.js in the environment,
    # load it with nvm
    command -v node > /dev/null || nvm use node
fi

# ------------------------------------------------------------------------------
# Custom .profile
[ -f ~/.extend.profile ] && . ~/.extend.profile;

# ------------------------------------------------------------------------------
npmbin;
composerbin;
