#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Download GTFS data from '$RELEASE_URL'" 1>&2
    curl -s --ciphers DEFAULT@SECLEVEL=1 "$RELEASE_URL"
fi
