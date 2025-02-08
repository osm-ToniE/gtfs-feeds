#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="601033a9f8ef84fd317562ae"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                                     | \
         jq -r '.resources[] | select(.format=="GTFS") | (.updated + "_" + .original_url)' | \
         sort                                                                              | \
         tail -1                                                                           | \
         sed -e 's/^.*Z_http/http/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
