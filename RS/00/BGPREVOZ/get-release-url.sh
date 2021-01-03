#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://data.gov.rs/sr/datasets/r/b4df09a9-579f-46b0-826f-f397a51e3786"

LOCATION=$(curl -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://data.gov.rs/s/resources/gtfs/.*\.zip$')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
