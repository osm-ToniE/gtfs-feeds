#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.vms.de/vms/service/downloads/"

SCANDATE=$(curl --connect-timeout 30 -s $SCANURL -o - | egrep -i 'href="https://www.vms.de/wp-content/uploads/.*/GTFS_VMS_[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].*?\.zip"' | tail -1 | sed -e 's/^.*GTFS_VMS_//i' -e 's/\.zip.*$//' -e 's/-.$//')

if [ -n "$SCANDATE" ]
then
    RELEASE_DATE=$SCANDATE
fi

echo $RELEASE_DATE
