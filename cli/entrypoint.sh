#!/bin/bash
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=us-east-1
which python
ls /usr/local/lib/python2.7/site-packages
find / -name "cookielib.py"
execution_name=$(date)
execution_name=(${execution_name// /_})
execution_name=(${execution_name//:/-})


