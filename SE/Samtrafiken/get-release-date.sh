#!/bin/bash

#
# get URL to download latest GTFS feed
#

BASEURL=https://data.samtrafiken.se/trafiklab/gtfs-sverige-2
YEAR=$(date +%Y)
MONTH=$(date +%m)

datepart=$(wget -O - $BASEURL/$YEAR/$MONTH/  2>&1                    | \
           grep 'href="sweden-20[0-9][0-9][0-9][0-9][0-9][0-9].zip"' | \
           tail -1                                                   | \
           sed -e 's/^.*href="sweden-//' -e 's/\.zip".*$//')

if [ -n "$datepart" ]
then
    result=$(date -d "$datepart" '+%Y-%m-%d')
    if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$result
    fi
fi

echo $RELEASE_DATE
