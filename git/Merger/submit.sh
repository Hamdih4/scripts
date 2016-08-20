#!/bin/bash

USAGE="Usage: $ submit.sh REPO_DIR BRANCH_NAME TARGET_REPO_URL"
START_DIR=$(pwd)
MODULES_DIR=../../common

RIPO_DIR=$1
BRANCH_NAME=$2
TARGET_REPO_DIR=$3

#############
# FUNCTIONS #
#############
function load_module {
  module=$1

  echo "Loading module $module"
  if ! source ${module} ; then
    echo "Failed to load module $module"
    exit 1
  fi 
}

function check_params {
  param_1=$1
  param_2=$2
  param_3=$3

  if [[ -z ${param_1} || -z ${param_2} || -z ${param_3} ]]; then
     print "$USAGE"
     print_fatal_error "Error: Missing params, please check usage!" 
  fi
}

function make_change {
  echo "adding text" >> README.md
}

##########
## MAIN ##
##########

load_module "$MODULES_DIR/print.sh"
load_module "$MODULES_DIR/dir.sh"
load_module "$MODULES_DIR/gh.sh"

check_params ${RIPO_DIR} ${BRANCH_NAME} ${TARGET_REPO_DIR}

#change_dir ${TARGET_RIPO_DIR}
#create_branch ${BRANCH_NAME}

change_dir ${RIPO_DIR}
create_branch ${BRANCH_NAME}

push_branch ${BRANCH_NAME}
make_change
add_files
commit "Updating README.md"
push
request_pull ${TARGET_REPO_DIR} ${BRANCH_NAME}

change_dir ${START_DIR}

