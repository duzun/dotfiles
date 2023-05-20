#!/usr/bin/env bash

export SUDO_ASKPASS="$(realpath "$_dotfiles/../src/gui_ask_pass.sh")"

if [[ $- = *i* ]] && [ -n "$DISPLAY" ] && [ "$UID" != "0" ]; then
    alias sudo="sudo -A"
fi
