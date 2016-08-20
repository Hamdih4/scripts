#!bin/bash

###############
# Print Error #
###############

function print_error {
  msg=$1

  tput setaf 1;
  echo ${msg}
  tput sgr0;
}

#####################
# Print Fatal Error #
#####################

function print_fatal_error {
  msg=$1

  print_error "$msg"
  exit 1;
}

##############
# Print Text #
##############

function print {
  msg=$1

  tput setaf 3;
  echo ${msg}
  tput sgr0;
}


#####################
# Print Header Text #
#####################

function print_header {
  msg=$1

  tput setaf 2;
  echo ${msg}
  tput sgr0;
}

