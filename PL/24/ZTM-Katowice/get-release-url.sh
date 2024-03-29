#!/bin/bash

#
# get URL to download latest GTFS feed
#

RELEASE_URL=https://gtfs.arc2.dev/24/ztm-katowice/$(curl --connect-timeout 30 -s https://gtfs.arc2.dev/24/ztm-katowice/ | \
              grep -io '<a href=['"'"'"][^"'"'"']*['"'"'"]'                                                             | \
              sed -e 's/^<a href=["'"'"']//i' -e 's/["'"'"']$//i'                                                       

if [ -n "$RELEASE_URL" ]
then
    echo $RELEASE_URL
fi
