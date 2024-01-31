#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://opendata.schleswig-holstein.de/dataset/fahrplandaten"
BASEURL="https://opendata.schleswig-holstein.de"

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
           egrep -i 'href="/dataset/.*/resource/777b9b5b-f24f-491b-a19b-e01bb5704bd2/download/fahrplandaten"' | \
           tail -1 | \
           sed -e 's/^.*href="//i' -e 's/fahrplandaten.*$/fahrplandaten/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="${BASEURL}$LOCATION"
fi

echo $RELEASE_URL
