#!/bin/bash

#
# get URL to download latest GTFS feed
#

source ../public-api.sh

WANTED=$(./get-feed-id.sh)

token=any

dsid=$(get_dataset_list $token | jq -r "map({ nameDe, id } | select( .nameDe == \"$WANTED\") | .id)[]")

if [ -n "$dsid" ]
then
    year=$(get_dataset $token $dsid | jq '.activeVersions[0] | .year' | sed -e 's/^\"//' -e 's/\"$//')

    if [ "$(echo $year | grep -c '^20[0-9][0-9]$')" == 1 ]
    then
        echo "${DBP_BASE}${ENDPOINT_DATA_SETS}/${dsid}/${year}/file"
    else
        echo ""
    fi
else
    echo ""
fi
