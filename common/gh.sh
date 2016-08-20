#!/bin/bash

## Prerequisites
##
## print.sh must be loaded before using this file
## dir.sh must be loaded before using this file

#############
# ADD FILES #
#############

function add_files {
  reset_dir=$1  

  print "Adding files"
  if ! git add . ; then
    change_dir ${reset_dir}
    print_fatal_error "No files to add or not a git repository"
  fi
}

##################
# COMMIT CHANGES #
##################

function commit {
  msg=$1
  reset_dir=$2

  print "Committing changes"
  if ! git commit -m "$msg" ; then
    change_dir ${reset_dir}
    print_fatal_error "Nothing to commit or not a git repository"
  fi
}

################
# PUSH CHANGES #
################

function push {
  reset_dir=$1

  print "Pushing changes to remote"
  if ! git push ; then
    change_dir ${reset_dir}
    print_fatal_error "Nothing to push or not a git repository"
  fi
}

#################
# SWITCH BRANCH #
#################

function switch_branch {
  branch=$1
  reset_dir=$2

  print "Switching to branch $branch"
  if ! git checkout ${branch} ; then
    change_dir ${reset_dir}
    print_fatal_error "Couldn't siwtch to branch $branch"
  fi
}

#################
# CREATE BRANCH #
#################

function create_branch {
  branch=$1
  reset_dir=$2

  print "Checking existance of branch $branch"
  if git rev-parse --verify ${branch} ; then
    return
  fi

  print "Creating branch $branch"
  if ! git checkout -b ${branch} ; then
    change_dir ${reset_dir}
    print_fatal_error "Couldn't create branch $branch"
  fi
}

#########################
# SHOW LIST OF BRANCHES #
# --------------------- #
# (1) All: "all"        #
# (2) Remote: "remotes" #
#########################

function list_branches {
  list=$1

  print "List of $list branches:"
  if ! git show-branch "--$list" ; then
    print_error "Error with git show-branch command"
  fi
}

###############
# PUSH BRANCH #
###############

function push_branch {
  branch=$1

  print "Pushing branch $branch"
  if ! git push --set-upstream origin ${branch} ; then
    print_fatal_error "Couldn't push branch $branch to remote"
  fi
}

#################
# DELETE BRANCH #
#################

function delete_branch {
  branch=$1

  print "Deleting branch $branch locally"
  if ! git branch -d ${branch} ; then
    print_fatal_error "Couldn't delete branch $branch locally"
  fi

  print "Deleting branch $branch remotely"
  if ! git push --set-upstream origin --delete ${branch} ; then
    print_fatal_error "Couldn't delete branch $branch remotely"
  fi 
}

##################
# GET REMOTE URL #
##################

function get_remote_url {
  #result="$(git remote get-url --all origin)"

  result=$(git config remote.origin.url)

  #printf "Remote URL: $result"

  #if ! ${result} ; then
  #  change_dir ${reset_dir}
  #  print_fatal_error "Couldn't get remote url"
  #fi

  echo "$result"
}

function substring {
  string=$1
  remove_last=$2

  echo ${string} | rev | cut -c ${remove_last}- | rev
}


#######################
# CREATE PULL REQUEST #
#######################

function request_pull {
  target_repo_dir=$1
  branch=$2
  
  target_repo_url=substring $(git config remote.origin.url) 4

  print "Opening pull request repo $target_repo_url branch $branch"
  open ${target_repo_url}/compare/${branch}

  #target_repo=get_remote_url
  #branch=$1
  #reset_dir=$2
  
  #if ! git request-pull ${target_repo} ${branch} ; then
  #  change_dir ${reset_dir}
  #  print_fatal_error "Couldn't create a pull request to $target_repo $branch"
  #fi
}

