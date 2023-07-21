#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    CURL_RESPONSE=$(curl --connect-timeout 30 -sI -o /dev/null -w "%{http_code}---%header{last-modified}\n" $RELEASE_URL)
    HTTP_CODE=$(echo $CURL_RESPONSE | sed -e 's/---.*$//')
    LAST_MODIFIED=$(echo $CURL_RESPONSE | sed -e 's/^.*---//')

    if [ "$HTTP_CODE" == "200" -a -n "$LAST_MODIFIED" ]
    then
        result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result
        fi
    fi
fi

echo $RELEASE_DATE
