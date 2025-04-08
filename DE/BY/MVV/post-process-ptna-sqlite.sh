#!/bin/bash

DB="ptna-gtfs-sqlite.db"

SQ_OPTIONS="-init /dev/null -batch -echo -csv -header"

if [ -f "$DB" ]
then
    # Bus N77 starts in GTFS with 2 times "Freiham Bahnhof", that's OK, so deletion of comment in DB

    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_start='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%33-N77-G-%' AND stop_name='Freiham Bf.' AND stop_sequence=2);"

    # Bus X204 ends in GTFS with 2 times "St. Achaz", that's OK, so deletion of comment in DB

    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_end='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-204-%' AND stop_name='St. Achaz' AND stop_sequence=14);"

    # Bus X732 has 2 trips with 2 stops only: Odelzhausen to Dasing 05:02 and 06:02 in GTFS, so deletion of comment in DB

    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_number_of_stops='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%20-732-%' AND stop_name='Dasing, Bahnhof' AND stop_sequence=2);"

    # Bus 222 starts in GTFS with 2 times "Deisenhofen West", that's OK, so deletion of comment in DB

    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_start='' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-222-%' AND stop_name='Deisenhofen West' AND stop_sequence=1);"

    # Bus 903 is in GTFS but not in PDF/WEB time tables

    for trip in $(sqlite3 $SQ_OPTIONS $DB "SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-903-%' AND stop_name='Söcking, Auersberg' AND stop_sequence=3;")
    do
        sqlite3 $SQ_OPTIONS $DB "INSERT OR IGNORE INTO ptna_trips_comments (trip_id,suspicious_other) VALUES ('$trip','Nicht im Online-Fahrplan enthalten');"
    done
    sqlite3 $SQ_OPTIONS $DB "UPDATE ptna_trips_comments SET suspicious_other='Nicht im Online-Fahrplan enthalten' WHERE trip_id IN (SELECT trip_id FROM stop_times JOIN stops ON stops.stop_id=stop_times.stop_id WHERE trip_id LIKE '%-903-%' AND stop_name='Söcking, Auersberg' AND stop_sequence=3);"
fi
