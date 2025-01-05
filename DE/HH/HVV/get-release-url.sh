#!/bin/bash

#
# get URL to download latest GTFS feed
#

BASEURL="https://suche.transparenz.hamburg.de/"

SCANURL="https://suche.transparenz.hamburg.de/?q=gtfs&sort=publishing_date+desc&limit=20&esq_not_all_versions=true"

LOCATION=$(curl -s $SCANURL -o - | \
           egrep -i 'href="/dataset/hvv-fahrplandaten-gtfs' | \
           head -1               | \
           sed -e 's/^.*href="//i' \
               -e 's/".*$//')

if [ -n "$LOCATION" ]
then
    SCANURL="${BASEURL}$LOCATION"

    LOCATION=$(curl -s $SCANURL -o - | \
               egrep -i 'href="https://daten.transparenz.hamburg.de/.*GTFS.*\.ZIP' | \
               head -1               | \
               sed -e 's/^.*href="//i' \
                   -e 's/".*$//')

    if [ -n "$LOCATION" ]
    then
        RELEASE_URL="$LOCATION"
    fi

fi

echo $RELEASE_URL
