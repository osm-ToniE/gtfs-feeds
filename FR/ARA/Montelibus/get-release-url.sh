#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.data.gouv.fr/fr/datasets/r/3c868712-8920-4ec8-a691-ff6876ecb29e"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'gtfs.zip')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
