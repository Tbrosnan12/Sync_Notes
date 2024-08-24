#!/bin/bash

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Warning: you are not in a git repo directory"
else
    up_to_date=true
    merger_issue=false
    done=false
    commit_message=""

    dir=$(git rev-parse --show-toplevel)
    repo_name=$(echo "${dir}" | awk -F '/' '{print $NF}')
    git_username=$(git config user.name)
    
    #check if there is a commit message
    if [ "$#" -gt 1 ]; then
        for i in $@; do
            commit_message+="${i} "      
        done
    fi

    #Fetch origin to compare 
    git fetch origin --quiet
    if git status | grep behind > /dev/null 2>&1; then  # pull from origin if behind
        echo "repo ${repo_name} is behind origin, pulling..."  
        git pull origin main --quiet
        done=true
        up_to_date=false
    fi
               
    if git status | grep "nothing to commit" > /dev/null 2>&1; then     # do nothing if nothing to add 
        if git status | grep "up to date with" > /dev/null 2>&1; then    #May be nothing to add, but still be a merger issue 
            done=true
        else
            merger_issue=true
            up_to_date=false
        fi
    fi


    if [ "$done" = "false" ]; then  #If stuff to add check if ahead 
        git add --all > /dev/null
        if [ -z "$commit_message" ]; then
            git commit -m "auto-sync" > /dev/null
        else
            git commit -m "${commit_message}" > /dev/null  #add optional commit message 
        fi
        if git status | grep ahead > /dev/null 2>&1; then   # push to origin if ahead
            echo "repo ${repo_name} is ahead of origin, pushing..."     
            git remote set-url origin git@github.com:${git_username}/${repo_name}.git
            git push origin main --quiet
        fi
        up_to_date=false
        done=true
    fi

    #if nothing has been "done" at this stage there is a merger issue
    if [ "$done" = "false" ]; then
        merger_issue=true
        up_to_date=false
    fi   

    #echo what has happened :)
    if [ "${up_to_date}" = "true" ]; then
        echo "No updates needed :)"      
    elif [ "$merger_issue" = true ]; then
        echo "Uh oh seems there is a merger issue :("         
    else
        echo "All done!"
    fi
fi