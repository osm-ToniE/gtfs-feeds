#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="66da461b80f91630d0227702"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION="$(curl --connect-timeout 30 -s $JSON_URL -o - | \
         jq '.resources[0] | .original_url'           | \
         sed -e 's/"//g' -e 's/\/$//')/"

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
