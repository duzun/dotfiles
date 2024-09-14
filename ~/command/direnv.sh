#!/usr/bin/env bash
# https://github.com/direnv/direnv

[ -n "$_shell" ] || _shell=$(shelltype)
eval "$(direnv hook "${_shell:-bash}")"

# In a new project run:
#   direnv edit .
# Add the desired env variables and paths, using `PATH_add path/to/bin`.
