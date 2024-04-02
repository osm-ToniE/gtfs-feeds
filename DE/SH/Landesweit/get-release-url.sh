#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://opendata.schleswig-holstein.de/dataset/fahrplandaten"
BASEURL="https://opendata.schleswig-holstein.de"

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
           egrep -E 'schema:url.*download/fahrplandaten' | \
           tail -1 | \
           sed -e 's/^.*http/http/i' -e 's/fahrplandaten.*$/fahrplandaten/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="$LOCATION"
fi

echo $RELEASE_URL
