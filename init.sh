#!/bin/bash

# @author Dumitru Uzun (DUzun.Me)
# @version 1.2.0

[ -e ~/.profile ] && [ ! -e ~/.extend.profile ] && mv ~/.profile ~/.extend.profile
[ -e ~/.aliasrc ] && [ ! -e ~/.extend.aliasrc ] && mv ~/.aliasrc ~/.extend.aliasrc

p="$(realpath `dirname $0`)/~"
ln -sf "$p/.profile" ~/
ln -s "$p/.aliasrc" ~/
ln -sf "$p/.gitignore" ~/
ln -sf "$p/.curlrc" ~/
ln -sf "$p/.vimrc" ~/

ls -a "$p" | grep '^\.extend\.' | while read i; do
    _mark="#dotfiles: $i";
    if [ -e ~/"$i" ] && grep "$_mark" ~/"$i" > /dev/null; then
        echo "$i not updated"
    else
        echo "Updating $i ..."
        echo "" >> ~/"$i";
        cat "$p/$i" >> ~/"$i";
        echo "" >> ~/"$i";
        echo $_mark >> ~/"$i";
    fi
done

. ~/.profile

# ln -sf "$p/.gitconfig" ~/
$p/../init_git.sh
