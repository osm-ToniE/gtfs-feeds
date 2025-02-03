#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Download GTFS data from '$RELEASE_URL' >> /dev/stderr
    wget --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" --header "Accept-Encoding: gzip" -O - "$RELEASE_URL$SE_SAMTRAFIKEN_APIKEY"
else
    echo "$(./get-feed-name.sh): could not evaluate release URL" >> /dev/stderr
    echo ""
fi
