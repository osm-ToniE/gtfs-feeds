#!/bin/bash

#
# get URL to download latest GTFS feed
#

RELEASE_URL=$(curl --connect-timeout 30 -s https://otwartedane.metropoliagzm.pl/dataset/86b5ce0c-daea-4b40-bc60-af2c80477d21.jsonld | \
              jq ' ."@graph"[]."dcat:accessURL"."@id"'                                                                              | \
              fgrep 'schedule'                                                                                                      | \
              sed -e 's/^"//' -e 's/"$//' -e 's/^\(.*\)\(schedule.*\)$/\2 \1/'                                                      | \
              sort -r                                                                                                               | \
              head -1                                                                                                               | \
              sed -e 's/^\(.*\) \(http.*\)$/\2\1/')

if [ -n "$RELEASE_URL" ]
then
    echo $RELEASE_URL
fi
