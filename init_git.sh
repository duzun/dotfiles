#!/bin/bash

hash git
if [[ $? > 0 ]]; then
    echo "Looks like git is not installed"
    exit 1
fi

p="$(realpath `dirname $0`)/~"
grep -v '^;' "$p/.gitconfig" | while read ln; do
    ln="${ln##*( )}"

    if [[ "${ln:0:1}" == "[" ]]; then
        ln=$(echo ${ln:1:-1} | tr -s '\ "' '.')
        _section=${ln%%.}
        # echo [$_section]
    else
        _name=${ln%%=*}
        _value=${ln:${#_name}+1}
        _value=${_value/# /}
        _name=${_name/% /}
        # echo $_section.$_name=$_value
        git config --global "$_section.$_name" "$_value"
    fi
done

_section=user
for _name in name email username; do
    _value=$(git config --global "$_section.$_name")
    _dv=" ($_value)"
    [ -z "$_value" ] && _dv=
    read -p "$_section.$_name$_dv:" v
    if [ ! -z "$v" ]; then
        git config --global "$_section.$_name" "$v"
    fi
done
