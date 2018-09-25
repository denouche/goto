#!/bin/bash

touch ~/.gotorc

goto()
{
    local to="$(echo $1 | tr '[:upper:]' '[:lower:]')"
    [ "$to" = "" ] && cd ~ && return

    # first check if equality rule can be found
    local gotofound
    while read folder; do
        local line="$(echo "$folder" | tr '[:upper:]' '[:lower:]')"
        [ "$line" != "" ] && [ "${line//:*/}" = "$to" ] && gotofound=${folder//*:/} && cd ${gotofound/\~/$HOME} && return
    done < <(cat ~/.gotorc | grep ':')

    # if not found, check in wildcard folders
    while read folder; do
        local line="$(echo "$(basename $folder):$folder" | tr '[:upper:]' '[:lower:]')"
        [ "$line" != "" ] && [ "${line//:*/}" = "$to" ] && gotofound=${folder//*:/} && cd ${gotofound/\~/$HOME} && return
    done < <(find $(cat ~/.gotorc | grep -v ':') -maxdepth 1 -type d)

    # if not found, check similarity in case of typo
    command -v tre-agrep >/dev/null 2>&1 || (echo "Install tre-agrep in order to check shortcut with similar spelling" && goto && return;)

    local similars=$(cat ~/.gotorc | grep ':' | cut -d':' -f1 | tre-agrep -i -1 "$to")
    if [ $( echo "$similars" | wc -l )  -eq 1 ]
    then
        goto $similars
    else
        echo "Multiple matching results found:"
        echo "$similars"
        goto
    fi
}

