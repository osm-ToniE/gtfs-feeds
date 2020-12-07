#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

LAST_MODIFIED=$(curl -sI $RELEASE_URL | fgrep -i 'last-modified:' | sed -e 's/^last-modified:\s*//i')

if [ -n "$LAST_MODIFIED" ]
then
    result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
    if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$result
    fi
fi

echo $RELEASE_DATE
