# Update

This is a repo holding scripts for auto syncing git repositories. 

Works best by adding this repo to your path.  

Then calling ```update``` in the terminal, when in a git repo, will update that repo. 

The main advantage is that these scripts will check weather your local repo is ahead(behind) origin and will then automatically push(pull) to update. 

Also includes passing of commit messages. The default message is ```auto-sync``` but typing anything next to update will pass it through as a commit message. For example: 

```
update this is a commit message
```

The other scripts in  ```Notes``` are for syncing notes directories. 

# Dependancies
[git](https://git-scm.com/downloads) 

