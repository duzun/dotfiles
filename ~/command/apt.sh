#!/usr/bin/env bash

if ! command -v update > /dev/null; then
    alias update="sudoif apt update && sudoif apt upgrade"
fi
