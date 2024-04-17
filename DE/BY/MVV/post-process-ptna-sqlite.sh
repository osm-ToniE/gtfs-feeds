#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null"

# Bus X204 ends in GTFS with 2 times "St. Achaz", that's OK, so deletion of comment in DB

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_end='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-204-%' AND stop_name='St. Achaz' AND stop_sequence=14);"

# Bus 222 starts in GTFS with 2 times "Deisenhofen West", that's OK, so deletion of comment in DB

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_start='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-222-%' AND stop_name='Deisenhofen West' AND stop_sequence=1);"
