#!/bin/bash

TODO="$HOME/.todo"

function output {
    cat $TODO | grep -v "^$" | cat -n | awk '{print $0 (/./ ? "\n" : "")}' | cut -c 6- | head -n -1
}

function add {
    last_n=$(output | tail -n -1 | awk '{print $1}')
    next_n=$(($last_n + 1))
    printf "$1\n\n" >> $TODO
}

function delete {
    line_n=$(output | grep "^$1" | awk '{print $1}')
    [[ -z "$line_n" ]] && echo "ERROR: you need to provide an existing activity number" && exit 1
    cat "$TODO" | grep -v "^$" | sed "$1"d | tee $TODO > /dev/null
}

while test $# -gt 0; do
  case "$1" in
    -h|--help)
        echo "options:"
        echo "-h, --help"
        echo "-a, --add=ACTIVITY"
        echo "-d, --delete=ACTIVITY"
        exit 0
        ;;
    -a|--add)
        shift
        add "$1"
        ;;
    -d|--delete)
        shift
        echo "DELETING ACTIVITY: $1"
        delete "$1"
        ;;
    *)
        output && exit 0
        break
        ;;
  esac
done

output
