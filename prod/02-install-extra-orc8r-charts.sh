#!/usr/bin/env bash

CONTROLLER_IMAGE="docker.artifactory.magmacore.org/controller"
CONTROLLER_TAG="1.5.0"

orc8r_helm_charts=("lte" "feg" "cwf" "wifi" "fbinternal")

for orc8r_chart in "${orc8r_helm_charts[@]}"
do 
  helm upgrade -i ${orc8r_chart}-orc8r orc8r/${orc8r_chart}-orc8r \
    --set controller.image.repository=${CONTROLLER_IMAGE} \
    --set controller.image.tag=${CONTROLLER_TAG}
done
