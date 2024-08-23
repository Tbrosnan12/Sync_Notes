#!/bin/bash

git_username=Tbrosnan12

git rev-parse --is-inside-work-tree | grep true > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Warning: you are not in a git repo directory"
else
    up_to_date=true
    merger_issue=false
    done=false
    commit_message=""

    dir=$(pwd)
    repo_name=$(echo "${dir}" | awk -F'/' '{print $NF}')

    if [ "$#" -gt 1 ]; then
        for i in $@; do
            commit_message+="${i} "     #check if there is a commit message 
        done
    fi

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
        git status | grep "up to date with" > /dev/null 2>&1   #May be nothing to add, but still be a merger issue 
        if [ $? = 0 ]; then
            done=true
        else
            merger_issue=true
            up_to_date=false
        fi
    fi


    if [ "$done" = "false" ]; then                #If stuff to add check if ahead 
        git add --all > /dev/null
        if [ -z "$commit_message" ]; then
            git commit -m "auto-sync" > /dev/null
        else
            git commit -m "${commit_message}" > /dev/null  #add optional commit message 
        fi
        git status | grep ahead > /dev/null
        if [ $? = 0 ]; then
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


    if [ "${up_to_date}" = "true" ]; then
        echo "All up to date :)"      
    elif [ "$merger_issue" = true ]; then
        echo "Uh oh seems there is a merger issue"         
    else
        echo "All done!"
    fi
fi