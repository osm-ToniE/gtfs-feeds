#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    CONTENT_DISPOSITION=$(curl --connect-timeout 30 -sI $RELEASE_URL | \
                        fgrep -i 'content-disposition:'              | \
                        sed -e 's/^content-disposition:.*filename="//i' -e 's/\.zip.*$//' | \
                        awk -F - '{printf "%s-%s-%s", $3, $2, $1; }')

    if [ -n "$CONTENT_DISPOSITION" ]
    then
        result=$(date -d "$CONTENT_DISPOSITION" '+%Y-%m-%d')
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result
        fi
    fi
fi

echo $RELEASE_DATE
