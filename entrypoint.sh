#!/bin/sh

set -e

mkdir -p ~/.aws
touch ~/.aws/credentials

echo "[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" > ~/.aws/credentials

# Coalesce filename if there are wildcards in it (grabs first match).
COALESCED_FILE=$(find ${SOURCE_PATH} -name "${FILE}" -type f -exec basename '{}' ';')

echo "Coalesced file is: $COALESCED_FILE"

# remove the existence check from the original repo and overwrite the file each time
(aws s3 cp ${SOURCE_PATH}"$COALESCED_FILE" s3://${AWS_S3_BUCKET}${DESTINATION_KEY} --region ${AWS_REGION} $*) && rm -rf ~/.aws
