USAGE="Usage: $ paste-to-file.sh FILE_NAME"

FILE_NAME=$1

if [[ -z ${FILE_NAME} ]]; then
  echo "$USAGE"
fi

pbpaste > ${FILE_NAME}
