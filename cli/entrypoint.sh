#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
execution_name=$(date)
execution_name=(${execution_name// /_})
execution_name=(${execution_name//:/-})

arn_value=$(aws cloudformation describe-stack-resources --stack-name githubactiontesting)
arn_value=$(echo $arn_value |jq '.StackResources[] | select(.ResourceType == "AWS::StepFunctions::StateMachine").PhysicalResourceId' | tr -d '"')

#2 integers
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 2_integers --input "{\"number1\":10, \"number2\":20}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output='$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi

#2 strings
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name $2_strings --input "{\"number1\":\"10\", \"number2\":\"20\"}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "FAILED" ]; then
	echo "Test Passed"
fi

#2 negative numbers
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 2_negative_numbers --input "{\"number1\":-10, \"number2\":-20}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi

#1 positive and 1 negative integer
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 1_positive_and_1_negative --input "{\"number1\":10, \"number2\":-20}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi

#1 float and 1 integer
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 1_float_and_1_integer --input "{\"number1\":10.30, \"number2\":20}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi

#1 float and 1 negative integer
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 1_float_and_1_negative_integer --input "{\"number1\":10.30, \"number2\":-20}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi

#2 large integers
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 2_large_integers --input "{\"number1\":100000000000, \"number2\":2000000000000}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi

#2 large float
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name 2_large_float --input "{\"number1\":100000000000.30, \"number2\":2000000000000.40}"| jq .executionArn | tr -d '"')
sleep 10s
outpt=$(aws stepfunctions describe-execution --execution-arn $execution_arn)
output=$(echo $output| jq .status| tr -d '"')
echo "Output = '$output'"
if [ "$output" == "SUCCEEDED" ]; then
	echo "Test Passed"
fi
