#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    headerfile=$(mktemp --tmpdir=$PWD)

    curl --connect-timeout 30 -sI $RELEASE_URL | sed -e 's/\s*\r$//' > $headerfile

    HTTPStatus=$(cat $headerfile | grep -E -i '^HTTP' | sed -e 's/[^0-9]*$//' -e 's|^HTTP/.*\s||')

    if [ "$HTTPStatus" = "200" ]
    then
        LAST_MODIFIED=$(cat $headerfile | grep -E -i 'last-modified:' | sed -e 's/^last-modified:\s*//i')

        if [ -n "$LAST_MODIFIED" ]
        then
            result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
            if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
            then
                RELEASE_DATE=$result
            fi
        fi
    else
        HTTPStatus=$(cat $headerfile | grep -E -i '^HTTP' > ./release_date_error.log)
    fi
    rm -f $headerfile
fi

echo $RELEASE_DATE
