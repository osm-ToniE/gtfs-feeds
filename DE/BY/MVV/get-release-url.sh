#!/bin/bash

#
# get URL to download latest GTFS feed
#

BASEURL="https://www.mvv-muenchen.de"
SCANURL="${BASEURL}/fahrplanauskunft/fuer-entwickler/opendata/index.html"

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
           egrep -i 'href="/fileadmin/mediapool/02-Fahrplanauskunft/03-Downloads/openData/.*?ohneShape.*?.zip"'  | \
           tail -1 | \
           sed -e 's/^.*href="//i' \
               -e 's/\.zip.*$/.zip/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$BASEURL$LOCATION
fi

echo $RELEASE_URL
