#!/bin/bash

#
# download latest ZIP file which contains 8 GTFS feed zips
#

FEED_NAME=$(./get-feed-name.sh)

WORKDIR=${FEED_NAME/-/\/}
WORKDIR=$PTNA_WORK_LOC/${WORKDIR%%-*}

GLOBAL_URL=$(./get-release-url.sh)

GLOBAL_ZIP=$WORKDIR/${FEED_NAME%-*}-temporary-gtfs.zip

MY_ID=${FEED_NAME##*-}

if [ ! -d "$WORKDIR" ]
then
    mkdir -p $WORKDIR
fi

if [ -d "$WORKDIR" ]
then
    if [ ! -f "$GLOBAL_ZIP" ]
    then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Download GTFS data from '$GLOBAL_URL' to '$GLOBAL_ZIP'" 1>&2
        wget --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" -O "$GLOBAL_ZIP" "$GLOBAL_URL" 1>&2
    fi

    if [ -f "$GLOBAL_ZIP" ]
    then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Extract '$MY_ID/*.zip' from '$GLOBAL_ZIP'" 1>&2
        unzip -p "$GLOBAL_ZIP" "$MY_ID/*.zip"
    else
        echo "$(date '+%Y-%m-%d %H:%M:%S') Could not create '$GLOBAL_ZIP'" 1>&2
    fi
else
    echo "$(date '+%Y-%m-%d %H:%M:%S') Could not create '$WORKDIR'" 1>&2
fi
