#!/bin/bash

#
# download latest GTFS feed data
#

source ../public-api.sh

WANTED=$(./get-feed-id.sh)

token=$(get_access_token)

dsid=$(get_dataset_list any | jq -r "map({ name, id } | select( .name == \"$WANTED\") | .id)[]")

if [ -n "$token" -a -n "$dsid" -a -n "$YEAR" ]
then
    download_dataset $token $dsid $YEAR
else
    echo ""
fi
