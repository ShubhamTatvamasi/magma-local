#!/usr/bin/env bash

set -e

CONTROLLER_IMAGE="docker.artifactory.magmacore.org/controller"
CONTROLLER_TAG="1.6.1"
DOMAIN_NAME=magmalocal.com
CERTS_CHART=false

helm upgrade -i orc8r orc8r/cloud/helm/orc8r \
  --set nginx.image.repository=shubhamtatvamasi/nginx \
  --set nginx.image.tag=magma-master-certs.0.1.1 \
  --set nginx.spec.hostname=controller.${DOMAIN_NAME} \
  --set metrics.enabled=false \
  --set nms.certs.enabled=${CERTS_CHART} \
  --set certs.domainName=${DOMAIN_NAME} \
  --set certs.enabled=${CERTS_CHART} \
  --set certs.create=${CERTS_CHART}

declare -A orc8r_helm_charts

orc8r_helm_charts=(
  [lte-orc8r]="lte/cloud/helm/lte-orc8r"
  [feg-orc8r]="feg/cloud/helm/feg-orc8r"
  [cwf-orc8r]="cwf/cloud/helm/cwf-orc8r"
  [wifi-orc8r]="wifi/cloud/helm/wifi-orc8r"
  [fbinternal-orc8r]="fbinternal/cloud/helm/fbinternal-orc8r"
)

for orc8r_chart in "${!orc8r_helm_charts[@]}"
do 
  helm upgrade -i ${orc8r_chart} ${orc8r_helm_charts[${orc8r_chart}]} \
    --set controller.image.repository=${CONTROLLER_IMAGE} \
    --set controller.image.tag=${CONTROLLER_TAG} \
    --set certs.enabled=${CERTS_CHART}
done
