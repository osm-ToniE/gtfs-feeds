#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://chouette.enroute.mobi/api/v1/datas/keolis_orleans.gtfs.zip"
LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'gtfs.zip')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
