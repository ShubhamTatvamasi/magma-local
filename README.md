# magma-local

- [Setup local kubernetes cluster](#setup-local-kubernetes-cluster)
- [Install prerequisites](#install-prerequisites)
- [Install Orc8r](#install-orc8r)

### Setup local kubernetes cluster

start a local kind kubernetes cluster:
```bash
kind create cluster
```

download magma docker images:
```bash
docker pull magmacore/nginx:1.4.0
docker pull magmacore/magmalte:1.4.0
docker pull magmacore/controller:1.4.0
```

load magma images on kind:
```bash
kind load docker-image magmacore/nginx:1.4.0
kind load docker-image magmacore/magmalte:1.4.0
kind load docker-image magmacore/controller:1.4.0
```

check if all the images are successfully loaded on kind cluster:
```bash
docker exec -it kind-control-plane crictl images
```
> Note: change your container name if it's not `kind-control-plane`

### Install prerequisites

install cert-manager
```bash
# add helm repo for cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update

# install cert-manager helm chart
helm install cert-manager jetstack/cert-manager \
  --create-namespace \
  --namespace cert-manager \
  --set installCRDs=true
```

### Install Orc8r

create new namespace:
```bash
kubectl create ns orc8r

# switch namespace to orc8r
kubens orc8r
```

create a soft-link for orc8rlib:
```bash
cd ${MAGMA_ROOT}/orc8r/cloud/helm/orc8r/charts/
ln -s ${MAGMA_ROOT}/orc8r/cloud/helm/orc8rlib orc8rlib
```

update orc8r dependencies:
```bash
helm dependency update
```
> no need if you have created soft-link for orc8rlib.

Go to orc8r helm repo directory:
```bash
cd ${MAGMA_ROOT}/orc8r/cloud/helm/orc8r/
```

Install postgresql:
```bash
helm install postgresql bitnami/postgresql \
  --set postgresqlPassword=postgres \
  --set postgresqlDatabase=magma \
  --set fullnameOverride=postgresql
```

```bash
helm install orc8r .
```

