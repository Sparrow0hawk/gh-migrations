#!/bin/bash

set -e

PGPASSWORD=$(terraform -chdir=cloud output -raw password)

docker run --rm -it \
    --network=host \
    -e PGPASSWORD=${PGPASSWORD} \
    postgres:15 \
    psql -h 127.0.0.1 -d gh-migration -U migration
