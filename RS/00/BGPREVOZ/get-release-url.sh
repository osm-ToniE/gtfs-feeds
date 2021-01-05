#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://data.gov.rs/sr/datasets/r/729be9a1-7ed9-453d-9a3d-68fa30f07529"

LOCATION=$(curl -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://data.gov.rs/s/resources/gtfs/.*\.zip$')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
