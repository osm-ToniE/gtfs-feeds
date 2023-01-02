#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-csv -header"

# Bus 222 starts in GTFS with 2 times "Deisenhofen", that's OK, so deletion of comment in DB

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_start='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-222-%' AND stop_name='Deisenhofen' AND stop_sequence=1);"
