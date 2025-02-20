#!/bin/bash

# this code runs in the folder where the GTFS feed *.zip file has been unpacked

#set -x

error_code=0

wiki_routes_files=$(find . -type f -name '*-Wiki-Routes-Page.txt')

if [ -n "$wiki_routes_files" ]
then
    for wiki_file in $wiki_routes_files
    do
        echo $(date "+%Y-%m-%d %H:%M:%S %Z") "start post publish for OSM wiki file '$wiki_file'"
        echo Nooooo
        echo $(date "+%Y-%m-%d %H:%M:%S %Z") "done post publish for OSM wiki file '$wiki_file'"
    done
else
    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "There are no OSM wiki files to be published"
fi

exit $error_code
