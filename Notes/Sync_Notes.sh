#!/bin/bash

#list of directories to Sync
Note_directories=("$HOME/Documents/Stylus_Labs_Write" "$HOME/Documents/TP_notes")

for dir in "${Note_directories[@]}"; do
    cd  $dir
    repo_name=$(echo "${dir}" | awk -F '/' '{print $NF}')
    echo "$repo_name:"
    update
done

