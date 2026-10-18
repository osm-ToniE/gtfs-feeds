#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.vms.de/GTFS_VMS.zip"

RESPONSE=$(curl --insecure --connect-timeout 30 -sI $PERMALINK)
LOCATION=$(echo $RESPONSE | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$RESPONSE" ]
then
    if [ -n "$LOCATION" ]
    then
        RELEASE_URL=$LOCATION
    fi
else
    echo "No data in response (timeout, blocked, ...)" > ./release_date_error.log
fi

echo $RELEASE_URL
