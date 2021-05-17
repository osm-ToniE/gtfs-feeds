#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.vms.de/vms/open-data-gtfs-daten/"

SCANDATE=$(curl -s $SCANURL -o - | egrep -i 'href="fileadmin/user_upload/GTFS-Daten/GTFS_VMS_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]\.zip"' | sed -e 's/^.*GTFS_VMS_//i' -e 's/\.zip.*$//')

if [ -n "$SCANDATE" ]
then
    RELEASE_DATE=$SCANDATE
fi

echo $RELEASE_DATE
