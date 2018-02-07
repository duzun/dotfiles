#!/bin/bash

# @author Dumitru Uzun (DUzun.Me)
# @version 1.3.0


# A method to move existing .profile to .extend.profile or .profile.bak
function toextend() {
    local name=$1
    if [ -s ~/".$name" ] && [ ! -L ~/".$name" ]; then
        local extend=.extend.$name
        if [ -s ~/"$extend" ]; then
            [ -s ~/".$name.bak" ] && echo "Overwriting ~/.$name.bak"
            mv ~/".$name" ~/".$name.bak"
        else
            # Old .profile becomes .extend.profile
            mv ~/".$name" ~/"$extend"

            # Avoid recursive sourcing
            sed -ri "s/((^|^[^#]*\s)(\.|source)\s+(\~|\\\$HOME)\/$extend)/#\\1/" ~/$extend
        fi
    fi
}

toextend profile
toextend aliasrc
unset -f toextend

# Make sure there is `realpath` command, if not, compile it
if ! command -v realpath > /dev/null; then
    _p=$(dirname "$0")
    _r="$_p/src/realpath"
    [ -x "$_r/realpath" ] || ( cd "$_r" && make ) && alias realpath="$("$_r/realpath" "$_r/realpath")"
fi

p=$(dirname "$0")
p="$(realpath "$p")/~"
ln -sf "$p/.profile" ~/
ln -sf "$p/.aliasrc" ~/
ln -s "$p/.gitignore" ~/
ln -s "$p/.curlrc" ~/
ln -s "$p/.vimrc" ~/

ls -a "$p" | grep '^\.extend\.' | while read -r i; do
    _mark="#dotfiles: $i";
    if [ -e ~/"$i" ] && grep "$_mark" ~/"$i" > /dev/null; then
        echo "$i not updated"
    else
        echo "Updating $i ..."
        {
            echo "";
            cat "$p/$i";
            echo "";
            echo "$_mark";
        } >> ~/"$i";
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
"$p"/../init_git.sh
