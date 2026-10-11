#!/bin/bash

# this code runs in the folder where the GTFS feed *.zip file has been unpacked

#set -x

gtfs-generic-post-analysis.sh --from=trip_headsign --to=trip_headsign

network="$(../get-feed-name.sh)"

if [ -f ./$network-catalog.json ]
then
    json_pp < ./$network-catalog.json > ./$network-catalog-pp.json

    sed -e 's/nchner Verkehrsgesellschaft mbH/nchner Verkehrsgesellschaft/' < ./$network-catalog-pp.json > ./$network-catalog.json

    rm -f ./$network-catalog-pp.json
fi

exit $?
