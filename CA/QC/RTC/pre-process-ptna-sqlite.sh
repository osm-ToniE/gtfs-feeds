#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then
    sqlite3 $SQ_OPTIONS $DB "UPDATE routes SET route_color=ltrim(route_color);"
    sqlite3 $SQ_OPTIONS $DB "UPDATE routes SET route_text_color=ltrim(route_text_color);"
fi
