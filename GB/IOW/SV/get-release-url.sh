#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.islandbuses.info/open-data/network/current?format=gtfs"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'southernvectis')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
