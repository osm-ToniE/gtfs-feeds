#!/bin/bash

#
# get URL to download latest GTFS feed
#

PERMALINK="https://www.vms.de/GTFS_VMS.zip"

LOCATION=$(curl --insecure --connect-timeout 30 -sI $PERMALINK | grep -F -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
