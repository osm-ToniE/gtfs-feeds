#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Download GTFS data from '$RELEASE_URL' >> /dev/stderr
    # wget --no-check-certificate --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" -O - "$RELEASE_URL"
    wget --no-check-certificate --no-verbose -O - "$RELEASE_URL"
fi
