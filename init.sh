#!/bin/bash -e

PROJECT="$(basename `pwd`)"
BUCKET="tfluc-infrastructure-state"

init() {
  if [ -d .terraform ]; then
    if [ -e .terraform/terraform.tfstate ]; then
      echo "Remote state already exist!"
      if [ -z $IGNORE_INIT ]; then
        exit 1
      fi
    fi
  fi


  terraform remote config \
    -backend=s3 \
    -backend-config="bucket=${BUCKET}" \
    -backend-config="key=${PROJECT}/terraform.tfstate" \
    -backend-config="region=us-east-1"

}

while getopts "i" opt; do
  case "$opt" in
    i)
      IGNORE_INIT="true"
      ;;
  esac
done

shift $((OPTIND-1))

init
