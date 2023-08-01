#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.data.gouv.fr/fr/datasets/r/35cf4d6c-a45b-442f-9cd0-a3293d344a9d"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'reseau-altigo')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
