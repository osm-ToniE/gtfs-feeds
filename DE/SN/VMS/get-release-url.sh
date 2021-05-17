#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.vms.de/vms/open-data-gtfs-daten/"

LOCATION=$(curl -s $SCANURL -o - | egrep -i 'href="fileadmin/user_upload/GTFS-Daten/GTFS_VMS_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]+\.zip"' | tail -1 | sed -e 's/^.*href="fileadmin/fileadmin/i' -e 's/\.zip.*$/.zip/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="https://www.vms.de/$LOCATION"
fi

echo $RELEASE_URL
