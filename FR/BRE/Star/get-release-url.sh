#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://transport.data.gouv.fr/resources/81437"

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
           egrep -i 'href="https://eu\.ftp\.opendatasoft\.com/star/gtfs/GTFS.*\.zip"' | \
           tail -1 | \
           sed -e 's/^.*href="https:/https:/i' \
               -e 's/\.zip.*$/.zip/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
