# This file name is deprecated in favour of dotfiles/~/source (which is symlinked to ~/.source)

_profile=${BASH_SOURCE:-$0}
# ------------------------------------------------------------------------------
if ! command -v realpath > /dev/null; then
    _realpath() {
        local _l _d
        _l=$1
        if [ -L "$_l" ]; then
            _l=$(readlink "$_l") || return $?
            # If symlink is relative:
            if [ "${_l:0:1}" != "/" ]; then
                _d=$(dirname "$1")
                [ "$_d" = "." ] && _d=${PWD:-$(pwd)}
                [ "$_d" != "." ] && [ -n "$_d" ] && _l="$_d/$_l"
            fi
        fi
        echo "$_l"
        [ -e "$_l" ]
    }

    _p=$(_realpath "$_profile")

    . "$_p/../src/realpath/.realpath"
fi

# ------------------------------------------------------------------------------
_profile=$(realpath "$_profile")
_dotfiles=$(dirname "$_profile")

. "$_dotfiles/source"
# . ~/.source


dotfiles_migrate() {
    if [ -L ~/.profile ] && [ "$(realpath ~/.profile)" = "$_dotfiles/.profile" ]; then
        echo "Migrating ~/.profile to ~/.source ..."
        rm -f -- ~/.profile && \
        cat << EOH > ~/.profile
# ------------------------------------------------------------------------------
# Include .dotfiles
. ~/.source

# ------------------------------------------------------------------------------
# Custom .profile
[ -f ~/.extend.profile ] && . ~/.extend.profile;

EOH
        echo "done with exit code $?"
    fi
}

dotfiles_migrate;
