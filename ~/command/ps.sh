#!/usr/bin/env bash

# grep process:
alias psgrep='ps aux | head -n1; ps aux | grep -v "\bgrep\b" | grep -i'
alias pu='ps -fu $USER'


# psmem [-g grep] [-u user] ... [-c] command
# @author DUzun.Me
psmem() {
    local help
    local cmd
    local user
    local grep
    local POSITIONAL=()

    # Parse parameters
    while [ $# -gt 0 ]; do
        local key="$1"

        case $key in
            -g|--grep)
                grep="$2"
                shift # past argument
                shift # past value
            ;;
            -u|--user)
                user="$2"
                shift # past argument
                shift # past value
            ;;
            -c|-C|--cmd)
                cmd="$2"
                shift # past argument
                shift # past value
            ;;
            --help)
                help=1
            ;;
            *)    # unknown option
                POSITIONAL+=("$1") # save it in an array for later
                shift # past argument
            ;;
        esac
    done

    set -- "${POSITIONAL[@]}" # restore positional parameters

    if [ -z "$cmd" ] && [ $# -gt 0 ]; then
        cmd="$1"
        shift
    fi

    local h=rss
    local a="$*"
    local e=

    # Show usage/help
    if [ -z "$cmd" ] && [ -z "$grep" ] && [ -z "$user" ] && [ -z "$a" ] || [ -n "$help" ]; then
        echo "Usage:"
        echo "   psmem [-g grep] [-u user] ... [-c] command"
        echo "   psmem --help"
        echo ""
        echo "   All extra parameters go to \`ps\`"
        return 1
    fi

    if [ -n "$user" ]; then
        a="$a -A"
        h="user,$h"
        e="$e | awk '\$1 == \"$user\"' | cut -d' ' -f1 -s --complement"
        if [ -n "$cmd" ]; then
            h="$h,comm"
            e="$e | awk '\$2 == \"$cmd\"'"
        else
            [ -n "$grep" ] && h="$h,comm"
        fi
    else
        if [ -n "$cmd" ]; then
            a="$a -C '$cmd'"
        else
            a="$a -A"
        fi
        [ -n "$grep" ] && h="$h,comm"
    fi

    local e="ps --no-headers -o '$h' $a$e"
    [ -n "$grep" ] && e="$e | grep -v grep | grep -i '$grep'"
    if [ "$h" != "rss" ]; then
        cmd=$(eval "$e" | awk '{print $2}' | sort | uniq -c | sort -k1 -nr | awk '{print "("$2" x"$1")"}')
        e="$e | awk '{print \$1}'"
    else
        cmd=;
    fi

    echo -n "${cmd[@]}" "RAM: "
    a=$(eval "$e")
    h=$(echo "${a[@]}" | wc -w)
    if [ "$h" -gt 0 ]; then
        echo -n "$( ( IFS=$'\n'; echo "${a[@]}" ) | awk '{ sum+=$1 } END { printf ("%s%d%s", "~", sum/NR/1024,"M") }') x$h = "
        ( IFS=$'\n'; echo "${a[@]}" ) | awk '{ sum+=$1 } END { printf ("%d%s", sum/1024,"M") }'
    else
        echo none
    fi
}

# @author DUzun.Me
psmemo() {
    local p=$1
    local g=$2
    local h=rss # comm
    local c
    [ -n "$g" ] && h=$h,user

    list() {
        if [ -z "$g" ]; then
            ps --no-headers -o "$h" -C $p
        else
            ps --no-headers -o "$h" -C $p | grep $g
        fi
    }

    c=$(list | wc -l)
    echo -n "\"$1"\" "RAM: "
    if [ "$c" -gt 0 ]; then
        echo -n "$(list | awk '{ sum+=$1 } END { printf ("%s%d%s", "~", sum/NR/1024,"M") }') x$c = "
        list | awk '{ sum+=$1 } END { printf ("%d%s", sum/1024,"M") }'
    else
        echo none
    fi
}
