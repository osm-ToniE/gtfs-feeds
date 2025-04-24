#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://github.com/Dimitar5555/sofiatraffic-gtfs/raw/master/result.zip"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'Dimitar5555')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
