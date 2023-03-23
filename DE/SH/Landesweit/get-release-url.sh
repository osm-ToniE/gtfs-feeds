#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://opendata.schleswig-holstein.de/dataset/fahrplandaten"
BASEURL="https://opendata.schleswig-holstein.de"

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | egrep -i 'href="/dataset/.*/download/fahrplandaten.zip"' | tail -1 | sed -e 's/^.*href="//i' -e 's/\.zip.*$/.zip/')


if [ -n "$LOCATION" ]
then
    RELEASE_URL="${BASEURL}$LOCATION"
fi

echo $RELEASE_URL
