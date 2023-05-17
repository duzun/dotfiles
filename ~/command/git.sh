#!/usr/bin/env bash

# Git
alias g="git"
alias gva="git status"
alias gv="gva ."
alias gvs="gv -s"
alias gda="git diff"
alias gdan="gda --name-status"
alias gd="gda ."
alias gdn="gdan ."
alias gdao="gda --cached"
alias gdo="gdao ."
alias ga="git add"
alias gap="ga -p"
alias gaa="ga --all"
alias guna="git rm --cached" # unadd
alias gunaa="git rm -r --cached ." # unadd all
alias gc="git commit"
alias gcm="gc -m"
alias gca="gc --amend --no-edit"
alias gcam="gc --amend"
alias gu="git push"
alias gut="gu --tags"
alias guf="gu -f"
alias gl="git pull"
alias gls="gl --rebase"
alias glo="gl origin"
alias gs="git rebase"
alias gsi="gs -i"
alias gss="gs --skip"
alias gsc="gs --continue"
alias gsa="gs --abort"
# alias gh="git checkout" # conflicts with github-cli
alias gco="git checkout"
alias ge="git merge"
alias gea="ge --abort"
alias gr="git remote"
alias gb="git branch"
alias gbu="git branch --set-upstream-to "
alias gt="git tag"
alias gf="git fetch"
alias gg="git log"
alias ggs="git log --stat"
alias ggso="git log --stat --oneline"
alias ggo="git log --oneline"
alias ggg="git log --oneline --all --graph --decorate"
alias gk="git cherry-pick"
alias gw="git show"
alias gw^="gw HEAD^"
alias gw^^="gw HEAD~2"
alias gw^^^="gw HEAD~3"
alias gw^^^^="gw HEAD~4"
alias gfg="git config --global"
alias gc_counts="git shortlog -s | sort -k1 -nr"
alias gc_total="git rev-list --all --count"


# `git commit -m` with date
# Accepted formats: "YYYY.MM.DD", "MM/DD/YYYY", "DD.MM.YYYY", RFC 2822 and ISO 8601
# See https://alexpeattie.com/blog/working-with-dates-in-git
tgcm() {
    local date=$1
    shift
    GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" gcm "$@" --date "$date"
}
