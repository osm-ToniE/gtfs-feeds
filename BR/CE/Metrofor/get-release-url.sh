#!/bin/bash

#
# get URL to download latest GTFS feed
#

#BASEURL="https://www.metrofor.ce.gov.br"
#SCANURL="${BASEURL}/gtfs/"

# <a href="https://www.metrofor.ce.gov.br/wp-content/uploads/sites/32/2025/01/gtfs_metrofor.zip">

#LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
#           grep -E -i 'href="https://www.metrofor.ce.gov.br/.*?/gtfs_metrofor\.zip">' | \
#           head -1               | \
#           sed -e 's/^.*href="//i' \
#               -e 's/".*$//')

#if [ -n "$LOCATION" ]
#then
#    RELEASE_URL="$LOCATION"
#fi

RELEASE_URL="https://info.metrofor.ce.gov.br/gtfs_file"

echo $RELEASE_URL
