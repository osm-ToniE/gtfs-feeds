#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then
    echo "nothing to do"
fi
