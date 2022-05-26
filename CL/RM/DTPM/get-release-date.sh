#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    # https://www.dtpm.cl/descargas/gtfs/GTFS-V70-PO20220228.zip

    DATESTRING=$(echo $RELEASE_URL | sed -e 's/^.*PO//i' -e 's/\.zip.*$//' -e 's/^\(20[0-9][0-9]\)\([01][0-9]\)\([0123][0-9]\)$/\1-\2-\3/')

    if [ "$(echo $DATESTRING | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$DATESTRING
    fi
fi

echo $RELEASE_DATE
