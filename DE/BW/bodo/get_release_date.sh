#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

GTFS_DATE_INFO_ParseUrl='https://www.nvbw.de/open-data/fahrplandaten/fahrplandaten-mit-liniennetz'


if [ "$1" = "-v" ]
then
    wget -O parse_date.tmp $GTFS_DATE_INFO_ParseUrl
else
    wget -O parse_date.tmp $GTFS_DATE_INFO_ParseUrl 2> /dev/null
fi

if [ -f "parse_date.tmp" -a -s "parse_date.tmp" ]
then
    perl -n -e 'if ( m/Bodensee-Oberschwaben Verkehrsverbund.*?Stand (\d\d)\.(\d\d)\.(\d\d\d\d)/ ) { printf( "%s-%s-%s\n", $3, $2, $1 ); }' parse_date.tmp
else
    echo $(date "+%Y-%m-%d %H:%M:%S") "Temporary file: 'parse_date.tmp' does not exist or is empty" >> /dev/stderr
    exit 1
fi
