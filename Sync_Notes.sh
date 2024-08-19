#!/bin/bash

#list of directories to Sync
Note_directories=("$HOME/Documents/Stylus_Labs_Write" "$HOME/Documents/TP_notes")

up_to_date=true

for dir in "${Note_directories[@]}"; do
    cd  $dir
    repo_name=$(echo "${dir}" | awk -F'/' '{print $NF}')
    done=false

    #Fetch origin to compare 
    git fetch origin --quiet
    git status | grep behind > /dev/null 2>&1      # pull from origin if behind
    if [ $? = 0 ]; then
        echo "repo ${repo_name} is behind origin, pulling..."  
        git pull origin main --quiet
        done=true
        up_to_date=false
    fi
                                                   # do nothing if nothing to add 
    git status | grep "nothing to commit" > /dev/null 2>&1
    if [ $? = 0 ]; then
        done=true
    fi

    if [ "$done" = "false" ]; then                #If stuff to add check if ahead 
        git add --all > /dev/null
        git commit -m "auto-sync" > /dev/null
        git status | grep ahead > /dev/null
        if [ $? = 0 ]; then
            echo "repo ${repo_name} is ahead of origin, pushing..."    # push to origin if ahead 
            git remote set-url origin git@github.com:Tbrosnan12/${repo_name}.git
            git push origin main --quiet
        fi
        up_to_date=false
        done=true
    fi   
done

if [ "${up_to_date}" = "true" ]; then
    echo "All up to date :)"      # If nothing happened :)
else
    echo "All done!"          # when finished
fi
