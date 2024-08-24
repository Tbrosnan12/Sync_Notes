#!/bin/bash

function pull() {
    local repo_name=$1 
    echo "repo ${repo_name} is behind origin, pulling..."  
    git pull origin main --quiet
}

function commit() {
    git add --all > /dev/null
    if [ -z "$commit_message" ]; then
        git commit -m "auto-sync" > /dev/null
    else
        git commit -m "${commit_message}" > /dev/null  #add optional commit message 
    fi
}

function push() {
    local repo_name=$1
    echo "repo ${repo_name} is ahead of origin, pushing..."     
    git remote set-url origin git@github.com:${git_username}/${repo_name}.git
    git push origin main --quiet
}



if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Warning: you are not in a git repo directory"
else
    up_to_date=false
    merger_issue=false
    commit_message=""

    dir=$(git rev-parse --show-toplevel)    #directory of top directory in the git repo tree
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

    if git status | grep "nothing to commit" > /dev/null 2>&1; then     # do nothing if nothing to add 
        if git status | grep "up to date with" > /dev/null 2>&1; then    #May be nothing to add, but still be a merger issue 
            up_to_date=true
        elif git status | grep behind > /dev/null 2>&1; then  # pull from origin if behind
            pull "${repo_name}"  
        else
            merger_issue=true
        fi
    else
        commit
        if git status | grep "diverged" > /dev/null 2>&1; then
            merger_issue=true
        elif git status | grep behind > /dev/null 2>&1; then  # pull from origin if behind
            pull "${repo_name}"
        elif git status | grep "up to date with" > /dev/null 2>&1; then    #May be nothing to add, but still be a merger issue 
            up_to_date=true
        elif git status | grep ahead > /dev/null 2>&1; then   # push to origin if ahead
            push "${repo_name}"
        fi
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