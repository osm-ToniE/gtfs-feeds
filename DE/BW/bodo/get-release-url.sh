#!/bin/bash

#
# get URL to download latest GTFS feed
#

Base="https://www.nvbw.de"

GTFS_URL_INFO_ParseUrl="$Base/open-data/fahrplandaten/fahrplandaten-mit-liniennetz"


if [ "$1" = "-v" ]
then
    wget -O parse_url.tmp $GTFS_URL_INFO_ParseUrl >> /dev/stderr
else
    wget -O parse_url.tmp $GTFS_URL_INFO_ParseUrl 2> /dev/null > /dev/null
fi

if [ -f "parse_url.tmp" -a -s "parse_url.tmp" ]
then
    Uri=$(perl -n -e 'if ( m/Bodensee-Oberschwaben Verkehrsverbund.*?href="([^"]*)">gtfs gezipt/ ) { $url = $1, $url =~ s/\&amp;/\&/g; printf( "%s\n", $url ); }' parse_url.tmp)
    if [ -n "$Uri" ]
    then
        echo "$Base$Uri"
    fi
else
    echo $(date "+%Y-%m-%d %H:%M:%S") "Temporary file: 'parse_url.tmp' does not exist or is empty" >> /dev/stderr
    exit 1
fi
