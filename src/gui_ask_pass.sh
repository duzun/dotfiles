#!/usr/bin/env bash

message="Please, enter your password"

if command -v kdialog >/dev/null; then
    kdialog --password "$message"
elif command -v zenity >/dev/null; then
    zenity --title="" --password 2>/dev/null
fi
