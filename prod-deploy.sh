#!/bin/sh

#docker build --no-cache -t gcr.io/prod-205719/dji .
#docker push gcr.io/prod-205719/dji:latest

gcloud beta run deploy dji2 --image gcr.io/prod-205719/dji:latest --verbosity="debug"\
  --user-output-enabled 
