#!/bin/bash

#
# download latest GTFS feed data
#

RELEASE_URL=$(./get-release-url.sh)

if [ -n "$RELEASE_URL" ]
then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Download GTFS data from '$RELEASE_URL'" 1>&2

    tempdir=$(mktemp -d CLgtfsXXX)

    cd $tempdir

    tempfile=$(mktemp CLgtfsXXX.zip)

    wget --no-verbose --user-agent "PTNA script on https://ptna.openstreetmap.de" -O $tempfile "$RELEASE_URL"

    unzip -o -- $tempfile 1>&2

    cd ..

    chmod -R 777 $tempdir

    find $tempdir -name 'gtf*.zip' -exec cat {} \;

    rm -rf $tempdir
fi
