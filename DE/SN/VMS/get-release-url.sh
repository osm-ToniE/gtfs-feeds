#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.vms.de/vms/service/downloads/"

# https://www.vms.de/wp-content/uploads/2025/04/GTFS_VMS.zip

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | grep -E -i 'href="https://www.vms.de/wp-content/uploads/.*?/GTFS_VMS.*?\.zip"' | tail -1 | sed -e 's/^.*href="//i' -e 's/\.zip.*$/.zip/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="$LOCATION"
fi

echo $RELEASE_URL
