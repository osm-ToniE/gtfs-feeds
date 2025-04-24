#!/bin/bash

#
# get URL to download latest GTFS feed
#

echo "https://gtfs.mfdz.de/SWISS.raw.gtfs.zip"

#PERMALINK="https://data.opentransportdata.swiss/de/dataset/timetable-2025-gtfs2020/permalink"
#
#LOCATION=$(curl --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')
#
#if [ -n "$LOCATION" ]
#then
#    if [ "$(echo $LOCATION | grep -c '^https://data.opentransportdata.swiss/')" == 1 ]
#    then
#        RELEASE_URL=$LOCATION
#    fi
#fi
#
#echo $RELEASE_URL
