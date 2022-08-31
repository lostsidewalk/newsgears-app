#!/bin/bash 

# grab latest commits from server
git submodule update --recursive --remote

# above command will set current branch to detached HEAD. set back to master.
git submodule foreach git checkout main

# now do pull to fast-forward to latest commit
git submodule foreach git pull origin main
