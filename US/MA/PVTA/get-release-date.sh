#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    HEADERS=$(curl --connect-timeout 30 -sI $RELEASE_URL)
    curl_ret_code=$?

    LAST_MODIFIED=$(echo $HEADERS | sed -e 's/\r /\n/g' | grep -F -i 'last-modified:' | sed -e 's/^last-modified:\s*//i')

    if [ -n "$LAST_MODIFIED" ]
    then
        result=$(date -d "$LAST_MODIFIED" '+%Y-%m-%d')
        if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
        then
            RELEASE_DATE=$result
        fi
    else
        if [ $curl_ret_code -ne 0 ]
        then
            if [ $curl_ret_code -eq 28 ]
            then
                echo "curl returned '$curl_ret_code' - timeout" > ./release_date_error.log
            elif [ $curl_ret_code -eq 35 ]
            then
                echo "curl returned '$curl_ret_code' - SSL connect error. The SSL handshaking failed" > ./release_date_error.log
            else
                echo "curl returned '$curl_ret_code'" > ./release_date_error.log
            fi
        else
            echo $HEADERS | sed -e 's/\r /\n/g' | grep -E '^HTTP' > ./release_date_error.log
        fi
    fi
fi

echo $RELEASE_DATE
