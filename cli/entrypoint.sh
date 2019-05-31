#!/bin/sh
cd sam_function
sam build --use-container
sam local start-api
