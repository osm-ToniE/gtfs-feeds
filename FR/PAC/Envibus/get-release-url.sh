#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="5be2ce698b4c414a99f9d84c"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

# Using permanent_url (cached on data.gouv.fr), because original_url (agglo-casa.fr) is blocked outside of France
LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                             | \
         jq -r '.history[] | .payload | select(.format=="GTFS") | .permanent_url'  | \
         sort                                                                      | \
         tail -1)
if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
