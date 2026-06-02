#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    LAST_MODIFIED=$(curl --connect-timeout 30 --ciphers DEFAULT@SECLEVEL=1 -sI $RELEASE_URL | grep -F -i 'last-modified:' | sed -e 's/^last-modified:\s*//i')

    if [ -n "$LAST_MODIFIED" ]
    then
        result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result
        fi
    else
        mkdir tempdir

        curl -s --ciphers DEFAULT@SECLEVEL=1 -o tempdir/gtfs.zip $RELEASE_URL

        if [ -f tempdir/gtfs.zip -a -s tempdir/gtfs.zip ]
        then
            result=$(unzip -l tempdir/gtfs.zip | awk '/20[0-9][0-9]-[0-9][0-9]-[0-9][0-9]/ { print $2; }' | sort -u | tail -1)
            if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
            then
                RELEASE_DATE=$result

                mv tempdir $RELEASE_DATE
            fi
        fi
    fi
fi

echo $RELEASE_DATE
