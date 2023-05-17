#!/usr/bin/env bash

# Docker
alias dv="docker ps"
alias dva="docker ps -a"
alias dn="docker run"
alias de="docker exec"
alias dei="docker exec -it"
alias ds="docker start"
alias dr="docker restart"
alias dt="docker stop"
alias dta="docker stop \$(docker ps -qa)"
alias dp="docker system prune -a"
alias dvrmd="docker volume rm \$(docker volume ls -f dangling=true -q)"
alias drm="docker rm"
alias drme="docker rm \$(docker ps -qa --no-trunc --filter 'status=exited')"
alias db="docker build"
alias dbt="docker build -t"

# Run a clean bash container with current folder mounted as /srv
alias dbash='docker run --rm -it -v "$(pwd):/srv" -w /srv bash'
