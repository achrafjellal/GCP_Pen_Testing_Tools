#!/bin/bash

# ANSI escape code for green text
GREEN='\033[0;32m'
# ANSI escape code to reset text color
RESET='\033[0m'

# Get a list of all project IDs
project_ids=$(gcloud projects list --format="value(projectId)")

# Count the total number of projects
total_projects=$(echo "$project_ids" | wc -l)

echo "Total projects: $total_projects"

# Counter for processed projects
processed_projects=0

# Loop through each project ID
for project_id in $project_ids
do
  # List BigTable instances in the current project, suppressing error messages
  bigtable_instances=$(gcloud bigtable instances list --project=$project_id --format="value(name)" 2>/dev/null)
  
  # Check if there are any BigTable instances in the current project
  if [ ! -z "$bigtable_instances" ]
  then
    # Print BigTable instances in green
    echo -e "${GREEN}BigTable instances in project $project_id:${RESET}"
    echo -e "${GREEN}$bigtable_instances${RESET}"
  fi

  # Increment the counter
  ((processed_projects++))

  # Print the progress bar
  echo -n "["
  for ((i=0; i<processed_projects; i++)); do echo -n "#"; done
  for ((i=processed_projects; i<total_projects; i++)); do echo -n " "; done
  echo -n "] $processed_projects/$total_projects"
  echo -ne "\r"
done

echo
