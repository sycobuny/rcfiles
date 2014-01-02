#!/usr/bin/env bash

# this script is courtesy of Jo Liss (@joliss on GitHub, @jo_liss on Twitter):
#   http://stackoverflow.com/a/4864668/302012

if [ "$#" = 0 ]; then
    [ -n "$(git config core.pager)" ] && PAGER=$(git config core.pager)

    (
        git diff --color
        git ls-files --others --exclude-standard |
            while read -r i; do git diff --color -- /dev/null "$i"; done
    ) | $PAGER
else
    git diff "$@"
fi
