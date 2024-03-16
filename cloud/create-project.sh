#!/usr/bin/env bash

set -e

if [ $# -eq 0 ]; then
    >&2 echo "Please provide a billing ID argument"
    exit 1
fi

gcloud auth application-default login

PROJECT=sparrow0hawk-gh-migration

# create project in gcp
gcloud projects create $PROJECT

# set current project with gcloud as this project
gcloud config set project $PROJECT

gcloud beta billing projects link $PROJECT \
 --billing-account $1
