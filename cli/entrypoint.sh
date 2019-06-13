#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
execution_name=$(date)
execution_name=(${execution_name// /_})
execution_name=(${execution_name//:/-})  
arn_value=$(aws stepfunctions create-state-machine --definition '{
              "Comment": "Add two numbers and then subtact the result of add with another number",
              "StartAt": "AddNumbers",
              "States": {
                "AddNumbers": {
                  "Type": "Task",
                  "Resource": "arn:aws:lambda:us-east-1:670868576168:function:githubactiontesting-AddFunction-1KWO14YS9KT41",
                  "Next": "SubtractNumbers"
                },
                  "SubtractNumbers": {
                  "Type": "Task",
                  "Resource": "arn:aws:lambda:us-east-1:670868576168:function:githubactiontesting-SubtractFunction-G5OHM6HZF29F",
                  "Parameters":{
                    "subtract from":40,
                    "number1.$":"$"
                  },
                  "End": true
                } 
              }
              }' --name "statemachine" --role-arn "arn:aws:iam::670868576168:role/lambda-vpc-role"| jq .stateMachineArn | tr -d '"')

#execution_arn=$(aws stepfunctions start-execution --state-machine $arn_value --name $execution_name --input "{\"number1\":10, \"number2\":20}"| jq .executionArn | tr -d '"')
#sleep 10s
#aws stepfunctions describe-execution --execution-arn $execution_arn
