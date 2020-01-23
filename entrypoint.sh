#!/bin/sh

AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?Need to set AWS_ACCESS_KEY_ID}
AWS_REGION=${AWS_REGION:?Need to set AWS_REGION}
AWS_S3_BUCKET=${AWS_S3_BUCKET:?Need to set AWS_S3_BUCKET}
AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?Need to set AWS_SECRET_ACCESS_KEY}
FILE=${FILE:?Need to set FILE}
KEY=${KEY:?Need to set KEY}

printf() {
  echo -e "\n\e[34m$1\e[39m\n"
}

set -e

mkdir -p ~/.aws
touch ~/.aws/credentials

echo "[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" > ~/.aws/credentials

if aws s3 ls "s3://$AWS_S3_BUCKET" 2>&1 | grep -q 'NoSuchBucket'
then
  printf "Create a bucket $AWS_S3_BUCKET:"

  aws s3api create-bucket \
  --acl private \
  --bucket $AWS_S3_BUCKET \
  --region $AWS_REGION \
  --create-bucket-configuration LocationConstraint=$AWS_REGION
fi

printf "Upload a file to a S3 bucket $AWS_S3_BUCKET:"

aws s3api put-object \
--storage-class STANDARD_IA \
--bucket $AWS_S3_BUCKET \
--key $KEY \
--body $FILE

rm -rf ~/.aws
