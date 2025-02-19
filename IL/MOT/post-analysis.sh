#!/bin/bash

# this code runs in the folder where the GTFS feed *.zip file has been unpacked

#set -x

error_code=0

gtfs_feed_name=$(../get-feed-name.sh)

ptna_networks="IL-D-Ashkelon            \
               IL-D-Beersheba           \
               IL-HA-Hadera             \
               IL-HA-Haifa              \
               IL-JM-Jerusalem          \
               IL-M-haSharon            \
               IL-M-Petah_Tikva         \
               IL-M-Ramala IL-M-Rehovot \
               IL-TA-Tel-Aviv           \
               IL-Z-Acre IL-Z-Golan     \
               IL-Z-Jezreel             \
               IL-Z-Kinneret            \
               IL-Z-Safed"

for network in $ptna_networks
do
    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "start post analysis for PTNA network '$network'"

    network_dir=$(find $PTNA_NETWORKS_LOC -type d -name $network)

    if [ -n "$network_dir" ]
    then
        if [ -f "$network_dir/settings.sh" -a -f "$network_dir/$network.geojson" ]
        then
            source "$network_dir/settings.sh"

            if [ -n "$WIKI_ROUTES_PAGE" ]
            then
                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "processing 'israelGtfsRoutesInShape.py --shape $network_dir/$network.geojson --gtfsdir . --outfile ./$network-catalog.json'"

                israelGtfsRoutesInShape.py --shape $network_dir/$network.geojson --gtfsdir $PWD --outfile ./$network-catalog.json
                ret_code=$?
                error_code=$(( $error_code + $ret_code ))

                if [ -f "./$network-catalog.json" -a -s "./$network-catalog.json" ]
                then
                    log=$(ptna-wiki-page.pl --pull --page=$WIKI_ROUTES_PAGE --file=./$network-Wiki-Routes-Page-old.txt 2>&1)
                    ret_code=$?
                    error_code=$(( $error_code + $ret_code ))
                    if [ -f "./$network-Wiki-Routes-Page-old.txt" ]
                    then
                        if [ $(grep -c '#REDIRECT *\[\[' ./$network-Wiki-Routes-Page-old.txt) -eq 0 ]
                        then
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "processing 'ptnaFillCsvData.py --routes ./$network-catalog.json --template ./$network-Wiki-Routes-Page-old.txt --outfile ./$network-Wiki-Routes-Page.txt'"

                            ptnaFillCsvData.py --routes ./$network-catalog.json --template ./$network-Wiki-Routes-Page-old.txt --outfile ./$network-Wiki-Routes-Page.txt
                            ret_code=$?
                            error_code=$(( $error_code + $ret_code ))

                            if [ -f "./$network-Wiki-Routes-Page.txt" -a -s "./$network-Wiki-Routes-Page.txt" ]
                            then
                                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "New '$network-Wiki-Routes-Page.txt' has been created"
                            else
                                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: creating new '$network-Wiki-Routes-Page.txt' failed with code: '$ret_code'"
                             fi
                        else
                            error_code=$(( $error_code + 1 ))
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: OSM Wiki page '$WIKI_ROUTES_PAGE' includes a '#REDIRECT ...'"
                        fi
                    else
                        echo $log | sed -e 's/ \([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] \)/\n\1/g'
                        echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: reading OSM Wiki page '$WIKI_ROUTES_PAGE' failed with code: '$ret_code'"
                    fi
                else
                    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: creating '$network-catalog.json' failed with code: '$ret_code'"
                fi
            else
                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: '$network' does not have routes data on the OSM Wiki"
            fi
        else
            if [ ! -f "$network_dir/settings.sh" ]
            then
                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: 'settings.sh' file for '$network' not found"
                error_code=$(( $error_code + 1 ))
            fi
            if [ ! -f "$network_dir/$network.geojson" ]
            then
                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: '$network.geojson' file for '$network' not found"
                error_code=$(( $error_code + 1 ))
            fi
        fi
    fi

    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "done post analysis for PTNA network '$network'"
done

exit $error_code
