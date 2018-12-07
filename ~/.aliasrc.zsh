#!/bin/zsh

# # Test whether a glob has any matches
# exists() {
#     local f=$1
#     if [ -e "$f" ] || [ -L "$f" ]; then return 0; fi

#     # If $1 is a pattern, we have to expand it in zsh:
#     set -- ${~f}(N) 2> /dev/null
#     [ "$f" = "$1" ] && return 1
#     [ -e "$1" ] || [ -L "$1" ]
#     return $?
# }
