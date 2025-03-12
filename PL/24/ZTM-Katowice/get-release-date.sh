#!/bin/bash

#
# retrieve release date of latest GTFS feed in form "YYYY-MM-DD"
#

echo $(curl -s https://api.github.com/repos/TransportGZM-GTFS-mirror/TransportGZM-GTFS-extended-ver/releases/latest | \
       jq -r '.assets[0].updated_at[0:10]')
