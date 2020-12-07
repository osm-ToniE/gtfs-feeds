#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://data.gov.rs/sr/datasets/r/d26fcb2a-c869-49c4-a7ac-1f90d0f69046"

LOCATION=$(curl -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://data.gov.rs/s/resources/gtfs/')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
