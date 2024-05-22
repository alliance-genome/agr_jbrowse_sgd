# agr_jbrowse_sgd

JBrowse server container for SGD's JBrowse

# Dockerfiles

This repo houses two docker files:

1. Dockerfile: this is the orginal JBrowse server docker file that has nginx
   and can be used to serve up SGD's JBrowse instance. It is no longer used in
   production, since the SGD JBrowse instance is driven by AWS Amplify and this
   repo: https://github.com/alliance-genome/agr_amplify_sgd_jbrowse1

2. Dockerfile.genNames: originally conceived of as a tool just to update
   JBrowse's name index, it now is designed to run periodically to get updated
   yeast GFF3, generate updated track data, update the name index and place
   new data in the AWS S3 bucket that drives the SGD JBrowse 1 instance.

# Typical usage

Build the docker image:

```
docker build -f Dockerfile.genNames -t sgd_update .
```

Run a docker container:

```
docker run -e "AWS_ACCESS_KEY=<accesskey>" -e "AWS_SECRET_KEY=<secretkey>" --rm  sgd_update
```
