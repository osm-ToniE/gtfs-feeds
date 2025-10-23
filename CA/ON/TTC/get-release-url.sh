#!/bin/bash

#
# get URL to download latest GTFS feed
#

PACKAGE="b811ead4-6eaf-4adb-8408-d389fb5a069c"

JSON_URL="https://ckan0.cf.opendata.inter.prod-toronto.ca/api/3/action/package_show?id=$PACKAGE"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o -                  | \
         jq -r '.result | .resources[] | select(.format=="ZIP") | .url' | \
         sort                                                           | \
         tail -1)

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
