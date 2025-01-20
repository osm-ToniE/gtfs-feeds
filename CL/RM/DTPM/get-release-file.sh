#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    tempdir=$(mktemp -d gtfsXXX)

    cd $tempdir

    tempfile=$(mktemp gtfsXXX.zip)

    wget --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" -O $tempfile "$RELEASE_URL"

    unzip -o -- $tempfile

    cd ..

    chmod -R 777 $tempdir

    find $tempdir -name 'gtf*.zip' -exec cat {} \;

    rm -rf $tempdir
fi
