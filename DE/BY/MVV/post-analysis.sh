#!/bin/bash

# this code runs in the folder where the GTFS feed *.zip file has been unpacked

#set -x

gtfs-generic-post-analysis.sh --from=trip_headsign --to=trip_headsign

network="$(../get-feed-name.sh)"

if [ -f ./$network-catalog.json ]
then
    json_pp < ./$network-catalog.json > ./$network-catalog-pp.json

    sed -e 's/nchner Verkehrsgesellschaft mbH/nchner Verkehrsgesellschaft/' \
        -e 's/"ref" : "531"/"ref" : "531\/07"/'                             \
        -e 's/"ref" : "590"/"ref" : "590\/47"/'                             \
        -e 's/"ref" : "592"/"ref" : "592\/60"/'                             \
        -e 's/"ref" : "593"/"ref" : "593\/63"/'                             \
        -e 's/"ref" : "597"/"ref" : "597\/67"/'                             \
        -e 's/"ref" : "662"/"ref" : "662\/50"/'                             \
        -e 's/"ref" : "671"/"ref" : "671\/11"/'                             \
        -e 's/"ref" : "683"/"ref" : "683\/51"/'                             \
        -e 's/"ref" : "6264"/"ref" : "6264\/46"/'                           \
        < ./$network-catalog-pp.json > ./$network-catalog.json

    rm ./$network-catalog-pp.json
fi

exit $?
