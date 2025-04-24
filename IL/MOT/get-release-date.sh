#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    RELEASE_DIR=${RELEASE_URL%/*}
    RELEASE_FILE=${RELEASE_URL##*/}
    LAST_MODIFIED=$(wget --no-check-certificate -O - $RELEASE_DIR 2>&1  | \
                    sed -e 's/<br>/\n/ig'                                   | \
                    grep -F "$RELEASE_FILE"                                   | \
                    sed -e 's/^\s*//' -e 's/\s.*$//')

    if [ -n "$LAST_MODIFIED" ]
    then
        result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result
        fi
    fi
fi

echo $RELEASE_DATE
