#!/bin/bash

# @author Dumitru Uzun (DUzun.Me)
# @version 1.0.1

p="$(realpath `dirname $0`)/~"
ln -sf "$p/.profile" ~/
ln -sf "$p/.gitignore" ~/
ln -sf "$p/.curlrc" ~/
ln -sf "$p/.vimrc" ~/

ls -a "$p" | grep '^\.extend\.' | while read i; do
    cat "$p/$i" >> ~/"$i";
done

. ~/.profile

# ln -sf "$p/.gitconfig" ~/
$p/../init_git.sh
