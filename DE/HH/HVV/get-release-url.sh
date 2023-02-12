#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.opendata-oepnv.de/ht/de/organisation/verkehrsverbuende/hvv/startseite?tx_vrrkit_view%5Bdataset_name%5D=soll-fahrplandaten-hvv&tx_vrrkit_view%5Bdataset_formats%5D%5B0%5D=ZIP&tx_vrrkit_view%5Baction%5D=details&tx_vrrkit_view%5Bcontroller%5D=View"

# https://www.opendata-oepnv.de/dataset/1e4084a2-147c-47e9-b79b-b7d57da6eee3/resource/5c94c4e9-ff3c-4f46-87ed-868c8fcfedd7/download/hvv_rohdaten_gtfs_fpl_20230202.zip

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
