#!/bin/bash

#
# get Date of active GTFS feed
#

source ../public-api.sh

WANTED=$(./get-feed-id.sh)

token=any

dsid=$(get_dataset_list $token | jq -r "map({ name, id } | select( .name == \"$WANTED\") | .id)[]")

created=$(get_dataset $token $dsid | jq '.activeVersion | .created' | sed -e 's/^\"//' -e 's/\"$//')

RELEASE_DATE=""

if [ -n "$created" ]
then
    result=$(date -d "$created" '+%Y-%m-%d')
    if [ "$(echo $result | grep -c '^20[0-9][0-9]-[01][0-9]-[0123][0-9]$')" == 1 ]
    then
        RELEASE_DATE=$result
    fi
fi

echo $RELEASE_DATE
