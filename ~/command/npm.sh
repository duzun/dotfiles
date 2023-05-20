#!/usr/bin/env bash

# NPM
alias nu="npm update"
alias ni="npm install"
alias ns="npm run --silent"
alias np="npm publish"
alias npp="npm publish --access=public"

_aliases_complete+=(
    nu ni ns np npp
)
