#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    mkdir tempdir

    curl -s --user-agent "PTNA @ ptna.openstreetmap.de" -o tempdir/gtfs.zip $RELEASE_URL

    ret_code=$?

    if [ $ret_code == 0 -a -f tempdir/gtfs.zip -a -s tempdir/gtfs.zip ]
    then
        result=$(unzip -l tempdir/gtfs.zip | awk '/20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ { print $2; }' | sort -u | tail -1)
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result

            mv tempdir $RELEASE_DATE
        fi
    else
        if $ret_code != 0 ]
        then
            if [ $ret_code == 28 ]
            then
                echo "curl returned '$ret_code' - timeout" > ./release_date_error.log
            else
                echo "curl returned '$ret_code'" > ./release_date_error.log
            fi
        fi
    fi
fi

echo $RELEASE_DATE
