#!/bin/bash

#list of directories to Sync
Note_directories=("$HOME/Documents/Stylus_Labs_Write" "$HOME/Documents/TP_notes")

up_to_date=true
merger_issue=false

for dir in "${Note_directories[@]}"; do
    cd  $dir
    repo_name=$(echo "${dir}" | awk -F'/' '{print $NF}')
    done=false

    #Fetch origin to compare 
    git fetch origin --quiet     
    if git status | grep behind > /dev/null 2>&1; then  # pull from origin if behind
        echo "repo ${repo_name} is behind origin, pulling..."  
        git pull origin main --quiet
        done=true
        up_to_date=false
    fi
                                                   
    if git status | grep "nothing to commit" > /dev/null 2>&1; then    # do nothing if nothing to add  
        if git status | grep "up to date with" > /dev/null 2>&1; then  #May be nothing to add, but still be a merger issue 
            done=true
        else
            merger_issue=true
            up_to_date=false
        fi
    fi

    if [ "$done" = "false" ]; then                #If stuff to add check if ahead 
        git add --all > /dev/null
        git commit -m "auto-sync" > /dev/null
        if git status | grep ahead > /dev/null 2>&1; then
            echo "repo ${repo_name} is ahead of origin, pushing..."    # push to origin if ahead 
            git remote set-url origin git@github.com:${git_username}/${repo_name}.git
            git push origin main --quiet
        fi
        up_to_date=false
        done=true
    fi
    if [ "$done" = "false" ]; then
        merger_issue=true
        up_to_date=false
    fi   
done

if [ "${up_to_date}" = "true" ]; then
    echo "No updates needed :)"      
elif [ "$merger_issue" = true ]; then
    echo "Uh oh seems there is a merger issue :("         
else
    echo "All done!"
fi
