#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.data.gouv.fr/api/1/datasets/r/6118ad14-0fdc-490d-a07c-e0efed8653d8"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c '^https://static.data.gouv.fr')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
