#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
aws stepfunctions describe-execution --execution-arn arn:aws:states:us-east-1:670868576168:execution:statemachine:test4
