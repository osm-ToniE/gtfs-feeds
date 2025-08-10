#!/bin/bash

#
# get URL to download latest GTFS feed
#

#SCANURL="https://www.zet.hr/odredbe/datoteke-u-gtfs-formatu/669"
#BASEURL="https://zet.hr"
#SCANURL="${BASEURL}/gtfs2"

#LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - |
#           grep -E -i 'href="https://www.zet.hr/UserDocsImages/Dokumenti i obrasci za preuzimanje/(GTFS.*[0-9]+\.[0-9]+\.[0-9][0-9][0-9][0-9]\..*|scheduled-.*?)\.zip' | \
#           head -1 | \
#           sed -e 's/^.*href="https:/https:/i' \
#               -e 's/".*$//'                   \
#               -e 's/ /%20/g')

#LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
#           sed -e 's/<\/a>/<\/a>\n/g' -e 's/<a>/<a>\n/g'  | \
#           grep -E -i 'href="/gtfs-scheduled/scheduled-.*?\.zip">GTFS Static Data Latest' | \
#           head -1               | \
#           sed -e 's/^.*href="//i' \
#               -e 's/".*$//'       \
#               -e 's/ /%20/g')

#if [ -n "$LOCATION" ]
#then
#    RELEASE_URL="${BASEURL}$LOCATION"
#fi

RELEASE_URL=https://zet.hr/gtfs-scheduled/latest

echo $RELEASE_URL
