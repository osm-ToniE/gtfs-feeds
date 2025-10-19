#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://data.calgary.ca/download/npk7-z3bj/application%2Fx-zip-compressed"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c -i 'GTFS')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
