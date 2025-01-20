#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="59aea7b3b595087a239169d7"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                  | \
         jq -r '.resources[] | select(.format=="GTFS") | .original_url' | \
         sort                                                           | \
         tail -1)

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'nicecotedazur')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
