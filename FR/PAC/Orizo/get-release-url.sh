#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="5ae2e01d88ee381811e691b5"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                  | \
         jq -r '.resources[] | select(.format=="GTFS") | .original_url' | \
         sort                                                           | \
         tail -1)

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
