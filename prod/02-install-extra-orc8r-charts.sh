#!/usr/bin/env bash

CONTROLLER_IMAGE="magmacore/controller"
CONTROLLER_TAG="1.5.2"
HELM_REPO="magma-charts-152"

orc8r_helm_charts=("lte" "feg" "cwf" "wifi" "fbinternal")

for orc8r_chart in "${orc8r_helm_charts[@]}"
do 
  helm upgrade -i ${orc8r_chart}-orc8r ${HELM_REPO}/${orc8r_chart}-orc8r \
    --set controller.image.repository=${CONTROLLER_IMAGE} \
    --set controller.image.tag=${CONTROLLER_TAG}
done
