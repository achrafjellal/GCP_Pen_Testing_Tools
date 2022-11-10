#!/bin/bash

#############################
# Run this tool to check if Cloud Shell is enabled on all projects on GCP.
#############################
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

for proj in $(gcloud projects list --format="get(projectId)"); do
    echo "[*] Checking $proj"
    for cloud in $proj 
    do
	echo " $cloud"

	ACL="$(gcloud cloud-shell ssh --authorize-session)"

        disabled="$(echo $ACL | grep ERROR:)"
        if [ -z "$disabled" ]
        then
              printf "${RED}[!] Cloud Shell Disabled${NC}\n"
        else
              printf "${GREEN}[!] Cloud Shell Enabled${NC}\n"
	fi

	done
    done


