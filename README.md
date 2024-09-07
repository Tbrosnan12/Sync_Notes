# Update

This is a repo holding scripts for auto syncing git repositories. 

Works best by adding this repo to your path, or you can just move ```update``` to a directory that is in your path.  

Then calling ```update``` in the terminal, when in a git repo, will update that repo. 

The main advantage is that these scripts will check weather your local repo is ahead(behind) origin and will then automatically push(pull) to update. 

Also includes passing of commit messages. The default message is ```auto-sync``` but typing anything next to update will pass it through as a commit message. For example: 

```
update this is a commit message
```
There are also options to check what the scropt will do with out actually pushing/[ulling or making commits (```update -c```).

Files that that are in the git repo directory but are not wanted in the push to origin can be excluded with ```update -e <files to exclude>```.

The other scripts in  ```Notes``` are for syncing notes directories. 

# Dependancies
[git](https://git-scm.com/downloads) 

# Flowchart 
![update_flowchart(1)](https://github.com/user-attachments/assets/e7a8ee91-acac-48b0-9cf1-14fbf10ab2a7)
