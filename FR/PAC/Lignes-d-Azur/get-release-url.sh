#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://opendata.nicecotedazur.org/data/dataset/export-quotidien-au-format-gtfs-du-reseau-de-transport-lignes-d-azur/resource/aacb4eea-d008-4b13-b17a-848b8ced7e03/download"

LOCATION=$(curl -sI $PERMALINK | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    if [ "$(echo $LOCATION | grep -c 'http://')" == 1 ]
    then
        OTHER_LOCATION=$(curl -sI $LOCATION | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')
        if [ "$(echo $OTHER_LOCATION | grep -c '//opendata.nicecotedazur.org/')" == 1 ]
        then
            RELEASE_URL=$OTHER_LOCATION
        fi
    else
        if [ "$(echo $LOCATION | grep -c '//opendata.nicecotedazur.org/')" == 1 ]
        then
            RELEASE_URL=$LOCATION
        fi
    fi
fi

echo $RELEASE_URL
