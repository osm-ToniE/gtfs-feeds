#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    wget --no-verbose --no-check-certificate -O - "$RELEASE_URL"
fi
