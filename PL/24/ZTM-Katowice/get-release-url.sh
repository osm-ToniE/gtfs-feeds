#!/bin/bash

#
# get URL to download latest GTFS feed
#

echo $(curl -s https://api.github.com/repos/TransportGZM-GTFS-mirror/TransportGZM-GTFS-extended-ver/releases/latest | \
       jq -r '.assets[0].browser_download_url')
