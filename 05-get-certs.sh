#!/usr/bin/env bash

set -e

kubectl get secrets orc8r-root-tls \
  -o jsonpath='{.data.tls\.crt}' | base64 -d > /tmp/rootCA.pem

kubectl get secrets orc8r-admin-operator-tls \
  -o jsonpath='{.data.keystore\.p12}' | base64 -d > /tmp/admin_operator.pfx
