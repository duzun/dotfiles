#!/bin/sh

: '###############################################

This is a script to install duzun/dotfiles

How to run:

curl -sLo- https://duzun.me/dotfiles.sh | sh
    or
wget -qO- https://duzun.me/dotfiles.sh | sh

See an up to date version at:
    https://raw.githubusercontent.com/duzun/dotfiles/master/install.sh

#  ###############################################'


repoUrl=https://github.com/duzun/dotfiles
homeDir=$HOME
[ -z "$homeDir" ] && homeDir=~

no_tools() {
    >&2 echo "Please, install git or unzip + curl"
    exit 4
}

hasCmd() {
    command -v "$1" > /dev/null
}

if [ -z "$homeDir" ]; then
    >&2 echo "Can't find the \$HOME environment variable"
    exit 1
fi

if [ ! -d "$homeDir" ]; then
    >&2 echo "Folder \"$homeDir\" not found"
    exit 2
fi


if hasCmd git; then
    git clone --recurse-submodules "$repoUrl".git "$homeDir"/.dotfiles
else
    hasCmd unzip || no_tools
    if hasCmd curl; then
        curl -sLo "$homeDir"/dotfiles.zip "$repoUrl/archive/master.zip"
    else
        wget -qO "$homeDir"/dotfiles.zip "$repoUrl/archive/master.zip"
    fi && \
    unzip "$homeDir"/dotfiles.zip -d "$homeDir" > /dev/null && \
    mv -- "$homeDir"/dotfiles-master "$homeDir"/.dotfiles && \
    rm -f -- "$homeDir"/dotfiles.zip
fi

if [ ! -s "$homeDir"/.dotfiles/~/source ]; then
    exit 3
fi

chmod +x "$homeDir"/.dotfiles/~/source

"$homeDir"/.dotfiles/~/source init && \
echo "Now run: . ~/.source"
