#!/bin/bash

MATCH=$(cat settings | grep match= | head -1 | cut -f2 -d"=")
ZONE=$(cat settings | grep zone= | head -1 | cut -f2 -d"=")

GCLOUD=$(which gcloud)

for i in $(${GCLOUD} compute instances list | grep ${MATCH} | cut -d " " -f 1);do 
  # gcloud compute instances stop $i
  $GCLOUD compute instances delete $i --zone $ZONE -q 
done

for i in $(${GCLOUD} compute routes list | grep ${MATCH} | cut -d " " -f 1);do 
  # gcloud compute instances stop $i
  $GCLOUD compute routes delete $i -q 
done
