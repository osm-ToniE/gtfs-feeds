#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    SCANDATE=$(echo $RELEASE_URL | grep -E 'GTFS.*[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]\.ZIP' | sed -e 's/^.*\([0-9][0-9][0-9][0-9]\)\([0-9][0-9]\)\([0-9][0-9]\).*$/\1-\2-\3/')

    if [ -n "$SCANDATE" ]
    then
        RELEASE_DATE=$SCANDATE
    fi
fi

echo $RELEASE_DATE
