#!/usr/bin/env bash

set -e

export MAGMA_ROOT="${PWD}"
export ORC8R_LIB_PATH="${MAGMA_ROOT}/orc8r/cloud/helm/orc8rlib"

declare -A orc8r_helm_charts

orc8r_helm_charts=( 
  [orc8r]="orc8r/cloud/helm/orc8r"
  [lte-orc8r]="lte/cloud/helm/lte-orc8r"
  [feg-orc8r]="feg/cloud/helm/feg-orc8r"
  [cwf-orc8r]="cwf/cloud/helm/cwf-orc8r"
  [wifi-orc8r]="wifi/cloud/helm/wifi-orc8r"
  [fbinternal-orc8r]="fbinternal/cloud/helm/fbinternal-orc8r"
)

for orc8r_chart in "${orc8r_helm_charts[@]}"
do 
  mkdir -p ${MAGMA_ROOT}/${orc8r_chart}/charts
  ln -s ${ORC8R_LIB_PATH} \
    ${MAGMA_ROOT}/${orc8r_chart}/charts/orc8rlib
done
