#!/bin/bash

p="$(realpath `dirname $0`)/~"
ln -sf "$p/.profile" ~/
ln -sf "$p/.gitconfig" ~/
ln -sf "$p/.gitignore" ~/
ln -sf "$p/.vimrc" ~/

ls -a "$p" | grep '^\.extend\.' | while read i; do
	cat "$p/$i" >> ~/"$i";
done

