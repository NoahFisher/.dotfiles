#!/bin/bash

# Print the raw credentials first
echo "Raw credentials:"
aws configure export-credentials --profile staging

# Store the credentials in variables
ACCESS_KEY=$(aws configure export-credentials --profile staging | jq -r '.AccessKeyId')
SECRET_KEY=$(aws configure export-credentials --profile staging | jq -r '.SecretAccessKey')
SESSION_TOKEN=$(aws configure export-credentials --profile staging | jq -r '.SessionToken')

# Export them
export AWS_ACCESS_KEY_ID=$ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
export AWS_SESSION_TOKEN=$SESSION_TOKEN

# Print the environment variables to verify
echo "Exported credentials:"
echo "AWS_ACCESS_KEY_ID: ${AWS_ACCESS_KEY_ID:0:5}..."
echo "AWS_SECRET_ACCESS_KEY: ${AWS_SECRET_ACCESS_KEY:0:5}..."
echo "AWS_SESSION_TOKEN: ${AWS_SESSION_TOKEN:0:5}..."
