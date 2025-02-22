#!/bin/bash

# this code runs in the folder where the GTFS feed *.zip file has been unpacked

#set -x

gtfs_feed=$(../get-feed-name.sh)

error_code=0

wiki_routes_files="$(find . -type f -name '*-Wiki-Routes-Page.txt')"

if [ -n "$wiki_routes_files" ]
then
    for wiki_file in $wiki_routes_files
    do
        wiki_file=${wiki_file#./}

        echo $(date "+%Y-%m-%d %H:%M:%S %Z") "start post publish for OSM wiki file '$wiki_file'"

        if [ -s "$wiki_file" ]
        then
            network=${wiki_file%%-Wiki-Routes-Page.txt}

            network_dir="$(find $PTNA_NETWORKS_LOC -type d -name $network)"

            if [ -f "$network_dir/settings.sh" ]
            then
                source "$network_dir/settings.sh"

                if [ -n "$WIKI_ROUTES_PAGE" ]
                then
                    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "processing OSM wiki file for network '$network'"

                    diff_size=-1
                    old_file=${wiki_file%%.txt}-old.txt
                    if [ -f "$old_file" -a -s "$old_file" ]
                    then
                        diff_file=${wiki_file%%.txt}.diff
                        diff $old_file $wiki_file > $diff_file
                        diff_size="$(stat -c '%s' $diff_file)"
                    fi

                    if [ $diff_size -ne 0 ]
                    then
                        # diff_size == -1 push without checking for difference
                        # diff_size >  0  push new contents

                        if [ $diff_size -eq -1 ]
                        then
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "writing '$wiki_file' to OSM Wiki page without checking for difference"
                        else
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "writing '$wiki_file' to OSM Wiki page difference (bytes: $diff_size)"
                        fi

                        log="$(ptna-wiki-page.pl --push --page=$WIKI_ROUTES_PAGE --file=./$network-Wiki-Routes-Page.txt --summary='Update by PTNA during import of GTFS feed: $gtfs_feed' 2>&1)"
                        ret_code=$?

                        echo $log | sed -e 's/ \([0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9] \)/\n\1/g'

                        if [ $ret_code -eq 0 ]
                        then
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "writing '$wiki_file' to OSM Wiki page '$WIKI_ROUTES_PAGE' succeeded"
                        else
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: writing '$wiki_file' to OSM Wiki page '$WIKI_ROUTES_PAGE' failed with code: '$ret_code'"
                            error_code=$(( $error_code + $ret_code ))
                        fi
                    else
                        if [ $diff_size -eq 0 ]
                        then
                            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Note: '$wiki_file': there is no difference to current contents"
                        fi
                    fi
                else
                    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Note: '$network' does not have routes data on the OSM Wiki"
                fi
            else
                echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: 'settings.sh' file for '$network' not found"
                error_code=$(( $error_code + 1 ))
            fi
        else
            echo $(date "+%Y-%m-%d %H:%M:%S %Z") "Error: '$wiki_file' file is empty"
            error_code=$(( $error_code + 1 ))
        fi

        echo $(date "+%Y-%m-%d %H:%M:%S %Z") "done post publish for OSM wiki file '$wiki_file'"
    done
else
    echo $(date "+%Y-%m-%d %H:%M:%S %Z") "There are no OSM wiki files to be published"
fi

exit $error_code
