#!/bin/bash

# @author Dumitru Uzun (DUzun.Me)
# @version 1.3.0


# A method to move existing .profile to .extend.profile or .profile.bak
function toextend() {
    local name=$1
    if [ -s ~/.$name -a ! -L ~/.$name ]; then
        local extend=.extend.$name
        if [ -s ~/$extend ]; then
            [ -s ~/.$name.bak ] && echo "Overwriting ~/.$name.bak"
            mv ~/.$name ~/.$name.bak
        else
            # Old .profile becomes .extend.profile
            mv ~/.$name ~/$extend

            # Avoid recursive sourcing
            sed -ri "s/((^|^[^#]*\s)(\.|source)\s+(\~|\\\$HOME)\/$extend)/#\\1/" ~/$extend
        fi
    fi
}

toextend profile
toextend aliasrc
unset -f toextend

p="$(realpath `dirname $0`)/~"
ln -sf "$p/.profile" ~/
ln -sf "$p/.aliasrc" ~/
ln -s "$p/.gitignore" ~/
ln -s "$p/.curlrc" ~/
ln -s "$p/.vimrc" ~/

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

# Try to take care of sourcing .profile automatically
if [ -n "$SHELL" ] && [ -f ~/".${SHELL##*/}rc" ]; then
    _rc=~/".${SHELL##*/}rc";
    if ! grep ". ~/.profile" "$_rc" > /dev/null && ! grep "source ~/.profile" "$_rc" > /dev/null; then
        echo "Adding '. ~/.profile' to $_rc ..."
        echo "" >> "$_rc"
        echo ". ~/.profile" >> "$_rc"
    fi
fi

# ln -sf "$p/.gitconfig" ~/
$p/../init_git.sh
