#!/bin/bash


## Prerequisites
##
## Requires print.sh to be loaded before using this file


####################
# Change Directory #
####################

function change_dir {
  dir=$1
  original_dir=$2

  if ! cd ${dir} ; then
    if [[ ! -z ${original_dir} ]]; then
       cd ${original_dir}
    fi    
    
    exit 1;
  fi
}

###############
# Rename File #
###############

function rename_file {
  src=$1
  target=$2

  if ! mv ${src} ${target} ; then
    print_fatal_error "Failed to rename $src file"
  fi
}
