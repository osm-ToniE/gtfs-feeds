#!/bin/bash

#
# get dataset list
#

source ./public-api.sh

token=any

get_dataset_list $token | json_pp
