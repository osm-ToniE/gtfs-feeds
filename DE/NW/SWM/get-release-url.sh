#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.stadtwerke-muenster.de/Externe%20Links/GTFS%20Open%20Data"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
