#!/usr/bin/env bash

# Same as Click to Run in Linux desktop, but for CLI.
command -v launch >/dev/null ||
    alias launch="gtk-launch"
