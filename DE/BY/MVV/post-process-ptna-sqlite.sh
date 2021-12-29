#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-csv -header"

# Bus 221 starts with 2 times "Waldheimplatz", that's OK

sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_start='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-221-%' AND stop_name='Waldheimplatz' AND stop_sequence=1);"
