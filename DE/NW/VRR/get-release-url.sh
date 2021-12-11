#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.opendata-oepnv.de/ht/de/organisation/verkehrsverbuende/vrr/startseite?tx_vrrkit_view%5Bdataset_name%5D=soll-fahrplandaten-vrr&tx_vrrkit_view%5Bdataset_formats%5D%5B0%5D=ZIP&tx_vrrkit_view%5Baction%5D=details&tx_vrrkit_view%5Bcontroller%5D=View"

LOCATION=$(curl -s $SCANURL -o - | \
           egrep -i 'href="https://.*opendata-oepnv.de/dataset/.*/download/.*\.zip"'  | \
           tail -1 | \
           sed -e 's/^.*href="https:/https:/i' \
               -e 's/www\.www\./www./' \
               -e 's/\.zip.*$/.zip/')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
