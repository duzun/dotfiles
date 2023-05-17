#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#alias ..="cd .."

# $ .. [nr]
# @author DUzun.Me
..() {
    local LASTDIR=$PWD
    local i=$1
    [ $# -eq 0 ] && i=1
    while [ $i -gt 0 ] && [ "$PWD" != "/" ]
    do
        cd ..
        i=$((i - 1))
    done
    export OLDPWD=$LASTDIR
    return $i
}

alias ...='cd ../..'
alias ....='cd ../../..'

# cd up to "partial_str"
# $ up "partial_str"
up() {
    local up;
    up=$(expr "$PWD" : "^\(.*$1[^/]*\)")
    [ "x$up" = "x" ] || cd "$up" || return 1
}

# Create directory and cd to it
mcd() {
    mkdir -p "$@" && cd "$_" || return $?
}

# ------------------------------------------------------------------------------
