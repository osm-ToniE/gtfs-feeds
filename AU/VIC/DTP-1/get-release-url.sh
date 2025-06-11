#!/bin/bash

#
# get URL to download latest GTFS feed
#

# this is a ZIP file which contans 8 gtfs.zip files
# for get-release-date.sh this is OK

SCANURL="https://opendata.transport.vic.gov.au/dataset/gtfs-schedule"

LOCATION=$(curl -s $SCANURL -o - | \
            grep -i -E 'href="https://opendata\.transport\.vic\.gov\.au/dataset/.*/resource/.*/download/gtfs\.zip"' | \
            head -1               | \
            sed -e 's/^.*href="//i' \
                -e 's/".*$//')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="$LOCATION"
fi

echo $RELEASE_URL
