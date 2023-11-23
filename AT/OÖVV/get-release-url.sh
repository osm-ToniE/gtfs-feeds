#!/bin/bash

#
# get URL to download latest GTFS feed
#

source ../public-api.sh

WANTED=$(./get-feed-id.sh)

token=any

dsid=$(get_dataset_list $token | jq -r "map({ name, id } | select( .name == \"$WANTED\") | .id)[]")

if [ -n "$dsid" ]
then
    echo "${DBP_BASE}${ENDPOINT_DATA_SETS}/${dsid}/${YEAR}/file"
else
    echo ""
fi
