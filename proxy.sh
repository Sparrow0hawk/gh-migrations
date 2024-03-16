#!/bin/bash

set -e

PRIVATE_KEY=$(terraform -chdir=cloud output -raw cloud_sql_proxy_private_key | base64 -d)
INSTANCE_CONNECTION_NAME=$(terraform -chdir=cloud output -raw connection_name)

docker run --rm \
    -p 127.0.0.1:5432:5432 \
    gcr.io/cloud-sql-connectors/cloud-sql-proxy:2.6.0 \
    --address 0.0.0.0 \
    --port 5432 \
    --json-credentials "${PRIVATE_KEY}" \
    ${INSTANCE_CONNECTION_NAME}
