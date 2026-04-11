#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://ckan.pbh.gov.br/dataset/af0c47bb-5a82-4ae1-874f-e45dea1397ff/resource/b2a9341e-4471-45cc-a8c0-11be805590bc/download/gtfsfiles.zip"

LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c -i 'GTFSBHTRANS')" == 1 ]
    then
        RELEASE_URL=$LOCATION
    fi
fi

echo $RELEASE_URL
