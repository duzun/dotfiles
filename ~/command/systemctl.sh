#!/usr/bin/env bash

# for systemd

systemctl="${1:-systemctl}"
# alias ss="systemctl"
alias ssv="systemctl status"
alias sss="sudoif ${systemctl} start"
alias sst="sudoif ${systemctl} stop"
alias ssl="sudoif ${systemctl} reload"
alias ssr="sudoif ${systemctl} restart"
alias sse="sudoif ${systemctl} enable"
alias ssls="$systemctl list-unit-files"
alias sslse="$systemctl list-unit-files --state=enabled"
alias sslsd="$systemctl list-unit-files --state=disabled"

alias sss_="${systemctl} start"
alias sst_="${systemctl} stop"
alias ssl_="${systemctl} reload"
alias ssr_="${systemctl} restart"
alias sse_="${systemctl} enable"
