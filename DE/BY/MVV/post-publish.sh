#!/bin/bash

# this code runs in the folder where the GTFS feed *.zip file has been unpacked

#set -x

gtfs-generic-post-publish.sh

exit $?
