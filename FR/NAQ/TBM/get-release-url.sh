#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="61a025b3a95e6e49a64ed7a0"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                                     | \
         jq -r '.resources[] | select(.format=="GTFS") | (.updated + "_" + .original_url)' | \
         grep -F 'static'                                                                  | \
         sort                                                                              | \
         tail -1                                                                           | \
         sed -e 's/^.*Z_http/http/')

if [ $(echo $LOCATION | grep -c '^http.*static') -eq 1 ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
