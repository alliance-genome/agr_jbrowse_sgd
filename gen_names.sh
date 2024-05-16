#!/usr/bin/bash

set -e

AWSACCESS=${AWS_ACCESS_KEY}
AWSSECRET=${AWS_SECRET_KEY}

cd /usr/share/nginx/html/jbrowse/data

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/seq seq/
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/trackList.json
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/tracks.conf
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/tracks tracks/

# convert absolut templateUrls to relataive
sed -i 's/https:.*SGD\/jbrowse\///g' trackList.json
sed -i 's/https:.*SGD\/jbrowse\/data\///g' tracks.conf

cd ..

bin/generate-names.pl 

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive --acl public-read data/names s3://agrjbrowse/test/sgd-names/

