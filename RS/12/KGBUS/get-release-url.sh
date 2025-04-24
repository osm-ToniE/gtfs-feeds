#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://data.gov.rs/sr/datasets/r/015f6bd4-1428-4ed8-b41e-c73d0885c79d"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://data.gov.rs/s/resources/.*/.*\.zip$')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
