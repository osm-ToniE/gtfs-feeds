#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    wget --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" --header "Accept-Encoding: gzip" -O - "$RELEASE_URL$SE_SAMTRAFIKEN_APIKEY"
else
    echo "$(./get-feed-name.sh): could not evaluate release URL" >> /dev/stderr
    echo ""
fi
