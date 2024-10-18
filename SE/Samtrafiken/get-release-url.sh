#!/bin/bash

#
# get URL to download latest GTFS feed
#

BASEURL=https://data.samtrafiken.se/trafiklab/gtfs-sverige-2
YEAR=$(date +%Y)
MONTH=$(date +%m)

result=$(wget -O - $BASEURL/$YEAR/$MONTH/  2>&1                     | \
         grep 'href="sweden-20[0-9][0-9][0-9][0-9][0-9][0-9].zip"'  | \
         tail -1                                                    | \
         sed -e 's/^.*href="//' -e 's/".*$//')

if [ -n "$result" ]
then
    RELEASE_URL="$BASEURL/$YEAR/$MONTH/$result"
fi

echo $RELEASE_URL
