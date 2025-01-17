#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    CONTENT_DISPOSITION=$(curl --connect-timeout 30 -sI $RELEASE_URL                | \
                          fgrep -i 'content-disposition:'                           | \
                          sed -e 's/^content-disposition:.*gtfs_//i' -e 's/_.*$//')

    if [ -n "$CONTENT_DISPOSITION" ]
    then
        result=$(date -d "$CONTENT_DISPOSITION" '+%Y-%m-%d' 2> ./release_date_error.log)
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result
        fi
    else
        curl --connect-timeout 30 -sI $RELEASE_URL | grep -i '^HTTP/' > ./release_date_error.log
    fi
fi

echo $RELEASE_DATE
