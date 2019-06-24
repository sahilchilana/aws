#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
find / -name "cookielib.py"
execution_name=$(date)
execution_name=(${execution_name// /_})
execution_name=(${execution_name//:/-})

variable=$(python scrape1.py)
echo $variable
arn_value=$(aws cloudformation describe-stack-resources --stack-name githubactiontesting)
arn_value=$(echo $arn_value |jq '.StackResources[] | select(.ResourceType == "AWS::StepFunctions::StateMachine").PhysicalResourceId' | tr -d '"')
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name $execution_name --input "{\"number1\":10, \"number2\":20}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output='$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi
