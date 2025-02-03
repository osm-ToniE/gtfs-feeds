#!/bin/bash

#
# download latest GTFS feed data
#

source ../public-api.sh

WANTED=$(./get-feed-id.sh)

token=$(get_access_token)

dsid=$(get_dataset_list any | jq -r "map({ nameDe, id } | select( .nameDe == \"$WANTED\") | .id)[]")

if [ -n "$token" -a -n "$dsid" ]
then
    year=$(get_dataset any $dsid | jq '.activeVersions[0] | .year' | sed -e 's/^\"//' -e 's/\"$//')

    if [ "$(echo $year | grep -c '^20[0-9][0-9]$')" == 1 ]
    then
        echo $(date "+%Y-%m-%d %H:%M:%S %Z") "download_dataset token $dsid $year" 1>&2
        download_dataset $token $dsid $year
    else
        echo "$PWD: could not get correct information for 'year' ($year)" 1>&2
        echo ""
    fi
else
    echo "$PWD: could not get correct information for 'token' ($token) and/or 'dsid' ($dsid)" 1>&2
    echo ""
fi
