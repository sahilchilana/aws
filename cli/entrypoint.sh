#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1

execution_name=$(date)
execution_name=(${execution_name// /_})
execution_name=(${execution_name//:/-})         
execution_arn=$(aws stepfunctions start-execution --state-machine arn:aws:states:us-east-1:670868576168:stateMachine:statemachine --name $execution_name --input "{\"number1\":10, \"number2\":20}"| jq .executionArn | tr -d '"')
sleep 10s
aws stepfunctions describe-execution --execution-arn $execution_arn
