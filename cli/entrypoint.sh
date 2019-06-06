#!/bin/bash
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1
aws cloudformation delete-stack --stack-name githubactiontesting
