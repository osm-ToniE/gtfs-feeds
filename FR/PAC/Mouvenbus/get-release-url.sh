#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="66da461b80f91630d0227702"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

ORIGINAL_URL=$(curl --connect-timeout 30 -s $JSON_URL -o -                                     | \
         jq -r '.resources[] | select(.format=="GTFS") | (.updated + "_" + .original_url)' | \
         sort                                                                              | \
         tail -1                                                                           | \
         sed -e 's/^.*Z_http/http/')

if [ -n "$ORIGINAL_URL" ]
then
    RELEASE_URL=$ORIGINAL_URL
fi

echo $RELEASE_URL
