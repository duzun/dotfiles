#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# yt-dlp
alias yta-aac="yt-dlp --extract-audio --audio-format aac "
alias yta-best="yt-dlp --extract-audio --audio-format best "
alias yta-flac="yt-dlp --extract-audio --audio-format flac "
alias yta-m4a="yt-dlp --extract-audio --audio-format m4a "
alias yta-mp3="yt-dlp --extract-audio --audio-format mp3 "
alias yta-opus="yt-dlp --extract-audio --audio-format opus "
alias yta-vorbis="yt-dlp --extract-audio --audio-format vorbis "
alias yta-wav="yt-dlp --extract-audio --audio-format wav "
alias ytv-best="yt-dlp -f bestvideo+bestaudio "

# Download playlist
alias ytp="yt-dlp -i --yes-playlist "

# List formats
alias ytl="yt-dlp -F "

# Download specific format
ytf() {
    yt-dlp -f "$1" "${@:2}"
}

_aliases_complete+=(
    ytl ytp
    yta-aac yta-best yta-flac yta-m4a yta-mp3 yta-opus yta-vorbis yta-wav ytv-best
)
