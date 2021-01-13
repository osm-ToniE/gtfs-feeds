#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://opentransportdata.swiss/de/dataset/timetable-2021-gtfs2020/permalink"

LOCATION=$(curl -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://opentransportdata.swiss/')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
