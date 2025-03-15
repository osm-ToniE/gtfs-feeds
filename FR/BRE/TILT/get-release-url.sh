#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="66512dc2e8c9915204e5a98b"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                  | \
         jq -r '.resources[] | select(.format=="GTFS") | .original_url' | \
         sort                                                           | \
         tail -1)

if [ -n "$LOCATION" ]
then
    LAST_MODIFIED=$(curl --connect-timeout 30 -sI $LOCATION | fgrep -i 'last-modified:' | sed -e 's/^last-modified:\s*//i')

    if [ -n "$LAST_MODIFIED" ]
    then
        RELEASE_URL=$LOCATION
    else
        LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                             | \
                 jq -r '.history[] | .payload | select(.format=="GTFS") | .permanent_url'  | \
                 sort                                                                      | \
                 tail -1)
        if [ -n "$LOCATION" ]
        then
            RELEASE_URL=$LOCATION
        fi
    fi
fi

echo $RELEASE_URL
