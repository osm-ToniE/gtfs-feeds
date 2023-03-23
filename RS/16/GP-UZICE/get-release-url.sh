#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://data.gov.rs/sr/datasets/r/b9c72d16-6c2c-46f8-8490-78a6ceefb8d8"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://data.gov.rs/s/resources/.*/.*\.zip$')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
