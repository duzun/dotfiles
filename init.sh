#!/bin/bash

p="$(realpath `dirname $0`)/~"
ln -sf "$p/.profile" ~/
ln -sf "$p/.gitignore" ~/
ln -sf "$p/.curlrc" ~/
ln -sf "$p/.vimrc" ~/

ls -a "$p" | grep '^\.extend\.' | while read i; do
    cat "$p/$i" >> ~/"$i";
done

# ln -sf "$p/.gitconfig" ~/
echo "git:"
$p/../init_git.sh
