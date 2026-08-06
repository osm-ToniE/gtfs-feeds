#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="6449c52caeceb71273a42dd3"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                                                          | \
         jq -r '.resources[] | select(.format=="GTFS") | select(.id==80921) | (.updated + "_" + .original_url)' | \
         sort                                                                                                   | \
         tail -1                                                                                                | \
         sed -e 's/^.*Z_http/http/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
