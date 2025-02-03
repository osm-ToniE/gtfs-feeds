#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Download GTFS data from '$RELEASE_URL' >> /dev/stderr
    wget --no-verbose --no-check-certificate -O - "$RELEASE_URL"
fi
