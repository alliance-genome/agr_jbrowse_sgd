#!/usr/bin/bash

set -e

AWSACCESS=${AWS_ACCESS_KEY}
AWSSECRET=${AWS_SECRET_KEY}

cd /usr/share/nginx/html/jbrowse

bin/generate-names.pl 

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive --acl public-read data/names s3://agrjbrowse/test/sgd-names/

