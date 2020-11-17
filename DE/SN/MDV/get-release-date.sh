#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

LAST_MODIFIED=$(wget --user-agent="PTNA @ ptna.openstreetmap.de" -S -O /dev/null $RELEASE_URL 2>&1 | fgrep -i 'last-modified:' | sed -e 's/^\s*last-modified:\s*//i')

if [ -n "$LAST_MODIFIED" ]
then
    result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
    if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$result
    fi
fi

echo $RELEASE_DATE
