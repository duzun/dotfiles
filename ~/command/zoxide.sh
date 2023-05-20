#!/usr/bin/env bash
# https://github.com/ajeetdsouza/zoxide

[ -n "$_shell" ] || _shell=$(shelltype)
eval "$(zoxide init "${_shell:-bash}")"
