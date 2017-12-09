    ######################
    #  DUzun's .profile  #
    #      Windows       #
    #   @version 1.3.0   #
    ######################


# Set user-defined locale
# export LANG=$(locale -uU)

# This is a DEV machine
[ -z "$ENV" ] && ENV=dev && export ENV

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    _os=osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    _os=linux
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    _os=windows
fi

export NVM_DIR=~/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

###############################################################################
# Shell behavior                                                              #
###############################################################################

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Append all commands to the history file; don't overwrite it at the start of every new session
shopt -s histappend

# Increase the history file size and set some sane defaults
export HISTSIZE=20000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTCONTROL=ignorespace # Don't store commands beginning with a space

function edit() {
    if [ -f "$EDITOR" ]; then
        command $EDITOR $@;
    else
        echo "Editor not found (\$EDITOR='$EDITOR')";
        return -1;
    fi;
}

function overdel() {
    p=`raelpath $1`
    find "$p" -type f | while read i; do
        s=`ls -l $i | awk '{print $5}'`; 
        echo "$s > $i"; 
        head -c $s < /dev/urandom > "$i";
        rm -rf "$i";
    done;
}

function npmbin() {
    local npmbin=`pwd`/node_modules/.bin;
    [ -d "$npmbin" ] && PATH=$npmbin:$PATH && echo $npmbin;
    return $?;
}

function composerbin() {
    local composerbin=`pwd`/vendor/bin;
    [ -d "$composerbin" ] && PATH=$composerbin:$PATH && echo $composerbin;
    return $?;
}

# Enable completion for aliases
complete -o default -o nospace -F _git_branch gb
complete -o default -o nospace -F _git_checkout gco

# If running interactively, set PS1
if [[ "$-" == *i* ]]
then
    if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
        . ~/.bash-git-prompt/gitprompt.sh
        GIT_PROMPT_ONLY_IN_REPO=1
    fi

    # If the git completion function exists, then use its built-in command prompt
    if command -v __git_ps1 > /dev/null; then
        export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h\[\033[36m\]`__git_ps1`\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n> ';
    else
        export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n> ';
    fi
fi

# Load OS speciffic .profile
# echo .: ${BASH_SOURCE[@]}
if [ -z "$BASH_SOURCE" ]; then local BASH_SOURCE=$_; fi

_profile=`realpath ${BASH_SOURCE[0]}`
_dotfiles=`dirname "$_profile"`

function inalias() {
    local p=$1
    [ -z "$p" ] && p=$_dotfiles;
    if [ -z "$p" ] ; then return 1; fi
    [ -f "$p/.aliasrc" ] && . "$p/.aliasrc";
    [ ! -z "$_os" ] && [ -f "$p/.aliasrc.$_os" ] && . "$p/.aliasrc.$_os";
    [ -f ~/.extend.aliasrc ] && . ~/.extend.aliasrc;
}

if [ ! -z "$_os" ] && [ -f "$_profile.$_os" ] ; then . "$_profile.$_os"; fi
inalias $_dotfiles;

npmbin;
composerbin;
