#!/bin/bash

#
# get URL to download latest GTFS feed
#

SCANURL="https://www.zet.hr/odredbe/datoteke-u-gtfs-formatu/669"

SCANDATE=$(curl -s $SCANURL -o - | \
           egrep -i 'href="https://www.zet.hr/UserDocsImages/Dokumenti i obrasci za preuzimanje/GTFS\s*-\s*[0-9]+\.[0-9]+\.[0-9][0-9][0-9][0-9]\.\.zip' | \
           head -1 | \
           sed -e 's/^.*GTFS\s*-\s*//i' \
               -e 's/\.\.zip.*$//')

if [ -n "$SCANDATE" ]
then
    SWAPPEDDATE=$(echo $SCANDATE | sed -e 's/\([0-9][0-9]*\)\.\([0-9][0-9]*\)\.\([0-9][0-9][0-9][0-9]\)/\3-\2-\1/')
    FIXEDDATE=$(date -d"$SWAPPEDDATE" '+%Y-%m-%d')
    if [ "$(echo $FIXEDDATE | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$FIXEDDATE
    fi
fi

echo $RELEASE_DATE
