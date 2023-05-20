#!/usr/bin/env bash

# Git
alias g="git"
alias gva="git status"
alias gv="gva ."
alias gvs="gv -s"
alias gda="git diff"
alias gdan="gda --name-status"
alias gd="gda ."
alias gdn="gdan ."
alias gdao="gda --cached"
alias gdo="gdao ."
alias ga="git add"
alias gap="ga -p"
alias gaa="ga --all"
alias guna="git rm --cached"       # unadd
alias gunaa="git rm -r --cached ." # unadd all
alias gc="git commit"
alias gcm="gc -m"
alias gca="gc --amend --no-edit"
alias gcam="gc --amend"
alias gu="git push"
alias gut="gu --tags"
alias guf="gu -f"
alias gl="git pull"
alias gls="gl --rebase"
alias glo="gl origin"
alias gs="git rebase"
alias gsi="gs -i"
alias gss="gs --skip"
alias gsc="gs --continue"
alias gsa="gs --abort"
# alias gh="git checkout" # conflicts with github-cli
alias gco="git checkout"
alias ge="git merge"
alias gea="ge --abort"
alias gr="git remote"
alias gb="git branch"
alias gbu="git branch --set-upstream-to "
alias gt="git tag"
alias gf="git fetch"
alias gg="git log"
alias ggs="git log --stat"
alias ggso="git log --stat --oneline"
alias ggo="git log --oneline"
alias ggg="git log --oneline --all --graph --decorate"
alias gk="git cherry-pick"
alias gw="git show"
alias gw^="gw HEAD^"
alias gw^^="gw HEAD~2"
alias gw^^^="gw HEAD~3"
alias gw^^^^="gw HEAD~4"
alias gfg="git config --global"
alias gc_counts="git shortlog -s | sort -k1 -nr"
alias gc_total="git rev-list --all --count"

# Init auto-complete for these aliases
_git_aliases_complete+=(
    gv gva gvs
    ga gap gaa
    gc gcm gca gcam
    gd gda gdao gdan
    gb gbu
    gu gut guf
    gl gls glo
    gco
    gk
    gs gsi gss gsc gsa
    gr
    gg ggo
    ge gea
    gt gf gfg
    gw gw^
)

_aliases_complete+=(
    g
)

# `git commit -m` with date
# Accepted formats: "YYYY.MM.DD", "MM/DD/YYYY", "DD.MM.YYYY", RFC 2822 and ISO 8601
# See https://alexpeattie.com/blog/working-with-dates-in-git
tgcm() {
    local date=$1
    shift
    GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" gcm "$@" --date "$date"
}

# ------------------------------------------------------------------------------
# Init git config.
# Usage: init_git [-f]
init_git() {
    if ! command -v git >/dev/null; then
        echo "Looks like git is not installed"
        return 1
    fi

    # [ -n "$BASH" ] && ! command -v __git_ps1 > /dev/null && [ ! -e ~/.git-prompt.sh ] && \
    # curl -L -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

    local _name _value _default _section _username _pv _dvb
    local gfg="git config --global"

    _force=$(echo "$@" | grep -- '-f')
    grep -v '^;' "$_dotfiles/.gitconfig" | while read -r ln; do
        ln="${ln##*( )}"
        if [[ "${ln:0:1}" == "[" ]]; then
            ln=$(echo "${ln:1:${#ln}-2}" | tr -s '\ "' '.')
            _section=${ln%%.}
            # echo [$_section]
        else
            _name=${ln%%=*}
            _value=${ln:${#_name}+1}
            _value=${_value/# /}
            _name=${_name/% /}
            # echo $_section.$_name=$_value
            $gfg "$_section.$_name" "$_value"
        fi
    done

    echo ""
    echo "$gfg:"
    _section=user
    _username=$(whoami)
    _value=
    for _name in name email username; do
        _pv=$_value
        _value=$($gfg "$_section.$_name")
        _default=$_value

        # Try to get a default value for missing git config
        if [ -z "$_default" ]; then
            if [[ "$_name" == "name" ]]; then
                _default=$(getent passwd "$_username" | cut -d: -f5 | cut -d, -f1)
            elif [[ "$_name" == "email" ]]; then
                _default="$_username@$(hostname)"
            elif [[ "$_name" == "username" ]]; then
                _default=$_username
                if [[ "$_default" == "root" ]] || [[ "$_default" == "user" ]]; then
                    if [ -n "$_pv" ]; then
                        _default=${_pv%%\@*}
                    fi
                fi
            fi
        fi

        _dvb=" ($_default)"
        [ -z "$_default" ] && _dvb=

        if [ -z "$_value" ] || [ -n "$_force" ]; then
            read -r -p "    $_section.$_name$_dvb:" v
            [ -z "$v" ] && [ -n "$_default" ] && v=$_default
            if [ -n "$v" ]; then
                $gfg "$_section.$_name" "$v"
                _value=$v
            fi
        else
            echo "    $_section.$_name: $_value"
        fi
    done

    local _q
    _name=credential.helper
    $gfg $_name >/dev/null
    _q=$?
    if [ -n "$_os" ] && [[ $_q != 0 || "$_name" == "store" ]]; then
        case $_os in
        linux)
            # Try to use KWallet if available
            _ask=$(command -v ksshaskpass) >/dev/null &&
                $gfg core.askpass "$_ask"

            # Try to use Gnome-Keyring if available
            command -v gnome-keyring >/dev/null &&
                $gfg $_name gnome-keyring
            ;;
        osx)
            $gfg $_name osxkeychain
            ;;
        windows)
            $gfg $_name wincred
            ;;
        esac
    fi
}
