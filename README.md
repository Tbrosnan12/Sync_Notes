# Sync_Notes

This is a repo holding scripts for auto syncing git repositories. 

Works best by adding this repo to your path as well as placing : ```alias Sync="Sync_Notes.sh"``` to your .bashrc or config of whatever shell you use. 

Then calling ```Sync``` in the terminal will update what ever repos are placed in in the "Note_directories" at the top of ```Sync_Notes.sh```. 

The main advantage is that these scripts will check weather your local repo is ahead(behind) origin and will then automatically push(pull) to update. 

The other script ```Sync_pdfs``` is for syncing pdfs from Latex documents to more conveniant locations. 

# Dependancies
[git](https://git-scm.com/downloads) 

