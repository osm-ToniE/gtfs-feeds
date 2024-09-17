#!/bin/bash

#
# get URL to download latest GTFS feed
#

#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="5ced52ed8b4c4177b679d377"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o - | \
         jq '.resources[0] | .original_url'           | \
         sed -e 's/"//g')

if [ -n "$LOCATION" ]
then
    RELEASE_URL=$LOCATION
fi

echo $RELEASE_URL
