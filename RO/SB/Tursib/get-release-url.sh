#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://tursib.ro/trasee/gtfs"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'tursib.gtfs')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
else
    curl --connect-timeout 30 -sI $PERMALINK | grep -i '^HTTP/' > ./release_date_error.log
fi

echo $RELEASE_URL
