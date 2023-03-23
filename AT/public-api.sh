#!/bin/bash

# for details see: https://mobilitaetsverbuende.atlassian.net/wiki/spaces/DBP/pages/185827383/Public+API+Download

KEYCLOAK="https://user.mobilitaetsverbuende.at"
REALM="dbp-public"
DBP_BASE=https://data.mobilitaetsverbuende.at
CLIENT_ID="dbp-script-download"
ENDPOINT_DATA_SETS=/api/public/v1/data-sets

# Get the access token
function get_access_token() {
    if [ -n "${AT_MOBILITAETSVERBUENDE_TOKEN}" ]
    then
        echo "${AT_MOBILITAETSVERBUENDE_TOKEN}"
    else
        if [ -n "${AT_MOBILITAETSVERBUENDE_USERNAME}" ]
        then
            MY_USERNAME="${AT_MOBILITAETSVERBUENDE_USERNAME}"
        else
            echo -n "Please enter username for Mobilitätsverbünde in Austria (https://data.mobilitaetsverbuende.at): " >> /dev/stderr
            read MY_USERNAME
        fi
        if [ -n "${AT_MOBILITAETSVERBUENDE_PASSWORD}" ]
        then
            MY_PASSWORD="${AT_MOBILITAETSVERBUENDE_PASSWORD}"
        else
            echo -n "Please enter password for Mobilitätsverbünde in Austria (https://data.mobilitaetsverbuende.at): " >> /dev/stderr
            read -s MY_PASSWORD
        fi
        curl --connect-timeout 30 -sS -k -X POST \
            -d "client_id=${CLIENT_ID}" \
            -d "username=${MY_USERNAME}" \
            -d "password=${MY_PASSWORD}" \
            -d "grant_type=password" \
            "${KEYCLOAK}/auth/realms/${REALM}/protocol/openid-connect/token" | jq -r '.access_token'
    fi
}

# List the existing datasets
# Needs access token
function get_dataset_list() {
    local token=$1
    curl --connect-timeout 30 -sS -k ${DBP_BASE}${ENDPOINT_DATA_SETS} \
        -H "Accept: application/json" \
        -H "Authorization: Bearer $token"
}

# Take the given dataset
# Needs access token and dataset id
function get_dataset() {
    local token=$1
    local id=$2
    curl --connect-timeout 30 -sS -k ${DBP_BASE}${ENDPOINT_DATA_SETS}/${id} \
        -H "Accept: application/json" \
        -H "Authorization: Bearer $token"
}

# Download the given dataset
# Needs access token and dataset id
function download_dataset() {
    local token=$1
    local id=$2
    curl --connect-timeout 30 -sS -k ${DBP_BASE}${ENDPOINT_DATA_SETS}/${id}/file \
        -H "Accept: application/zip" \
        -H "Authorization: Bearer $token"
}
