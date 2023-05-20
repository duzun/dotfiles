#!/usr/bin/env bash
# general purpose fuzzy search: https://github.com/junegunn/fzf

alias fvim="fzf --bind 'enter:become(vim {})'"

s="${_shell:-bash}"

for i in \
    "/usr/share/fzf/completion.$s" \
    "/usr/share/fzf/key-bindings.$s" \
    "/usr/share/doc/fzf/examples/key-bindings.$s" \
    /usr/share/bash-completion/completions/fzf; do
    [ -s "$i" ] && source "$i"
done
