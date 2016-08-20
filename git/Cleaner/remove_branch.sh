#!/bin/bash

USAGE="Usage: $ remove_branch.sh REPO_DIR BRANCH_NAME"
START_DIR=$(pwd)
MODULES_DIR=../../common

RIPO_DIR=$1
BRANCH_NAME=$2

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
  ripo_dir=$1
  branch_name=$2

  if [[ -z ${ripo_dir} || -z ${branch_name} ]]; then
     print "$USAGE"
     print_fatal_error "Error: Missing params, please check usage!" 
  fi

}
########
# MAIN #
########

load_module "$MODULES_DIR/print.sh"
load_module "$MODULES_DIR/dir.sh"
load_module "$MODULES_DIR/gh.sh"

check_params ${RIPO_DIR} ${BRANCH_NAME}
change_dir ${RIPO_DIR}
switch_branch "master"
delete_branch ${BRANCH_NAME}
change_dir ${START_DIR}
