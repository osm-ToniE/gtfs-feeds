#!/bin/bash

#
# get URL to download latest GTFS feed
#

echo "https://www.mvv-muenchen.de/fileadmin/mediapool/02-Fahrplanauskunft/03-Downloads/openData/mvv_gtfs.zip"

#SCANURL="https://www.opendata-oepnv.de/ht/de/organisation/verkehrsverbuende/mvv/startseite?tx_vrrkit_view%5Bdataset_name%5D=soll_fahrplandaten_mvv&tx_vrrkit_view%5Baction%5D=details&tx_vrrkit_view%5Bcontroller%5D=View"

#LOCATION=$(curl -s $SCANURL -o - | \
#           egrep -i 'href="https://.*opendata-oepnv.de/dataset/.*/download/.*\.zip"'  | \
#           tail -1 | \
#           sed -e 's/^.*href="https:/https:/i' \
#               -e 's/www\.www\./www./' \
#               -e 's/\.zip.*$/.zip/')

#if [ -n "$LOCATION" ]
#then
#    RELEASE_URL=$LOCATION
#fi

#echo $RELEASE_URL
