#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="6582c0551499a457530f4c93"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

ORIGINAL_URL=$(curl --connect-timeout 30 -s $JSON_URL -o -                                     | \
         jq -r '.resources[] | select(.format=="GTFS") | (.updated + "_" + .original_url)' | \
         sort                                                                              | \
         tail -1                                                                           | \
         sed -e 's/^.*Z_http/http/')

if [ -n "$ORIGINAL_URL" ]
then
    LOCATION=$(curl --connect-timeout 30 -sI $ORIGINAL_URL | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

    if [ -n "$LOCATION" ]
    then
        RELEASE_URL=${ORIGINAL_URL%%.fr/*}.fr/$LOCATION
    else
        RELEASE_URL=$ORIGINAL_URL
    fi
fi

echo $RELEASE_URL
