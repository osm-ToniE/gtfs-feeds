#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    mkdir tempdir

    wget -q -O tempdir/gtfs.zip --user-agent="PTNA @ ptna.openstreetmap.de" $RELEASE_URL

    if [ -f tempdir/gtfs.zip -a -s tempdir/gtfs.zip ]
    then
        result=$(unzip -l tempdir/gtfs.zip 2> ./release_date_error.log | awk '/20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ { print $2; }' | sort -u | tail -1)
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result

            mv tempdir $RELEASE_DATE
        else
            if [ $(grep -c -i 'cannot find zipfile directory' ./release_date_error.log) -eq 1 ]
            then
                echo "Not a ZIP file" > ./release_date_error.log
            fi
            rm -rf tempdir
        fi
    fi
fi

echo $RELEASE_DATE
