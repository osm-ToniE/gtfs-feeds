#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

mkdir tempdir

wget -q -O tempdir/gtfs.zip $RELEASE_URL

if [ -f tempdir/gtfs.zip -a -s tempdir/gtfs.zip ]
then
    result=$(unzip -l tempdir/gtfs.zip | awk '/20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ { print $2; }' | sort -u | tail -1)
    if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$result

        mv tempdir $RELEASE_DATE
    fi
fi

echo $RELEASE_DATE
