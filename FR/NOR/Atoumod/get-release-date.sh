#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

DATASET_ID="5ced52ed8b4c4177b679d377"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

UPDATED=$(curl --connect-timeout 30 -s $JSON_URL -o -                                     | \
        jq -r '.resources[] | select(.format=="GTFS") | (.updated + "_" + .original_url)' | \
        grep -F 'static'                                                                  | \
        sort                                                                              | \
        tail -1                                                                           | \
        sed -e 's/T.*$//')

if [ $(echo $UPDATED | egrep -c '^20[0-9][0-9]-[0-1][0-9]-[0-3][0-9]$') -eq 1 ]
then
    RELEASE_DATE=$UPDATED
fi

echo $RELEASE_DATE
