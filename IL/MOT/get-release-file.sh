#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    wget --no-check-certificate --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" -O - "$RELEASE_URL"
fi
