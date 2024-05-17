#!/usr/bin/bash

set -e

AWSACCESS=${AWS_ACCESS_KEY}
AWSSECRET=${AWS_SECRET_KEY}

cd /jbrowse/data

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/seq seq/
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/trackList.json
curl -O https://stage.dh18454tea1gu.amplifyapp.com/data/tracks.conf
AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive s3://agrjbrowse/MOD-jbrowses/SGD/jbrowse/data/tracks tracks/

# convert absolut templateUrls to relataive
sed -i 's/https:.*SGD\/jbrowse\///g' trackList.json
sed -i 's/https:.*SGD\/jbrowse\/data\///g' tracks.conf

cd ..

# simple index everything command
#bin/generate-names.pl 


#specifying what tracks to index
bin/generate-names.pl -v --tracks \
"All Annotated Sequence Features",\
"cDNA_transcripts",\
"longest_full-ORF_transcripts_ypd",\
"longest_full-ORF_transcripts_gal",\
"most_abundant_full-ORF_transcripts_gal",\
"most_abundant_full-ORF_transcripts_ypd",\
"unfiltered_full-ORF_transcripts",\
"cryptic_unstable_transcripts",\
"open_reading_frame_transcripts",\
"other_transcripts",\
"stable_unannotated_transcripts"

AWS_ACCESS_KEY_ID=$AWSACCESS AWS_SECRET_ACCESS_KEY=$AWSSECRET aws s3 cp --recursive --acl public-read data/names s3://agrjbrowse/test/sgd-names/

