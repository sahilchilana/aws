#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
execution_name=$(date)
execution_name=(${execution_name// /_})
execution_name=(${execution_name//:/-})
all_functions=$(aws lambda list-functions --region us-east-1 --query 'Functions[?starts_with(FunctionName, `githubactiontesting`) == `true`].FunctionName' --output text)
first_function_name=$(echo $all_functions | cut -d ' ' -f 1)
second_function_name=$(echo $all_functions | cut -d ' ' -f 2)
first_function_arn=$(aws lambda get-function --function-name $first_function_name)
first_function_arn=$(echo $first_function_arn | jq .Configuration.FunctionArn)
second_function_arn=$(aws lambda get-function --function-name $second_function_name)
second_function_arn=$(echo $second_function_arn | jq .Configuration.FunctionArn)
arn_value=$(aws stepfunctions create-state-machine --definition '{
              "Comment": "Add two numbers and then subtact the result of add with another number",
              "StartAt": "AddNumbers",
              "States": {
                "AddNumbers": {
                  "Type": "Task",
                  "Resource": $first_function_arn,
                  "Next": "SubtractNumbers"
                },
                  "SubtractNumbers": {
                  "Type": "Task",
                  "Resource": $second_function_arn,
                  "Parameters":{
                    "subtract from":40,
                    "number1.$":"$"
                  },
                  "End": true
                } 
              }
              }' --name "statemachine" --role-arn "arn:aws:iam::670868576168:role/lambda-vpc-role" 2>&1)
if [[ $arn_value = *error* ]]; then
  error_value=$(echo $arn_value | grep error)
  arn_value=$(echo $error_value | cut -d "'" -f 2)
else 
  arn_value=$(echo $arn_value | jq .stateMachineArn | tr -d '"')
fi
echo $arn_value
execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name $execution_name --input "{\"number1\":10, \"number2\":20}"| jq .executionArn | tr -d '"')
sleep 10s
aws stepfunctions describe-execution --execution-arn $execution_arn
