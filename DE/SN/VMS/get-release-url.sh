#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.vms.de/vms/service/downloads/"

LOCATION=$(curl -s $SCANURL -o - | egrep -i 'href="https://www.vms.de/wp-content/uploads/.*/GTFS_VMS_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]+\.zip"' | tail -1 | sed -e 's/^.*href="//i' -e 's/\.zip.*$/.zip/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="$LOCATION"
fi

echo $RELEASE_URL
