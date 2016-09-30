USAGE="Usage: $ copy-from-file.sh FILE_NAME"

FILE_NAME=$1

if [[ -z ${FILE_NAME} ]]; then
  echo "$USAGE"
fi

pbcopy < ${FILE_NAME}
