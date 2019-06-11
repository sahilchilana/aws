#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_KEY
export AWS_DEFAULT_REGION=us-east-1
aws stepfunctions create-state-machine --definition '{
              "Comment": "Add two numbers and then subtact the result of add with another number",
              "StartAt": "AddNumbers",
              "States": {
                "AddNumbers": {
                  "Type": "Task",
                  "Resource": "arn:aws:lambda:us-east-1:670868576168:function:githubactiontesting-AddFunction-1KWO14YS9KT41",
                  "Parameters":{
                      "number1":10,
                      "number2":20
                  },
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
              }
            }' --name "statemachine" --role-arn "arn:aws:iam::670868576168:role/githubactiontesting-AddFunctionRole-828QDZ3VB97V"
