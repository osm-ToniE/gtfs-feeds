#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then
    # on request by community
    # https://community.openstreetmap.org/t/ptna-news-for-public-transport-network-analysis/8383/145
    #
    # the trips and shapes related to these routes will be deleted during the aggregation step
    #
    # delete route_type = 205 == 'Special Coach Service' from DB
    sqlite3 $SQ_OPTIONS $DB "DELETE FROM routes WHERE route_type='205';"

    # delete route_type = 712 == 'School Bus'
    sqlite3 $SQ_OPTIONS $DB "DELETE FROM routes WHERE route_type='712';"

    # delete route_type = 714 == 'Rail Replacement Bus Service'
    sqlite3 $SQ_OPTIONS $DB "DELETE FROM routes WHERE route_type='714';"

    # store this task's information in the 'comment' field of the table 'ptna'
    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna SET comment='Deleted route_types 205, 712 and 714. See: https://community.openstreetmap.org/t/ptna-news-for-public-transport-network-analysis/8383/145';"
fi
