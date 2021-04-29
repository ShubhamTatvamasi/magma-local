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

docker pull shubhamtatvamasi/nginx:magma-master-certs.0.1.0

# These will be used in future:
docker pull docker.artifactory.magmacore.org/nginx:1.5.0
docker pull docker.artifactory.magmacore.org/magmalte:1.5.0
docker pull docker.artifactory.magmacore.org/controller:1.5.0
```

load magma images on kind:
```bash
kind load docker-image magmacore/nginx:1.4.0
kind load docker-image magmacore/magmalte:1.4.0
kind load docker-image magmacore/controller:1.4.0

kind load docker-image shubhamtatvamasi/nginx:magma-master-certs.0.1.0
kind load docker-image docker.artifactory.magmacore.org/magmalte:1.5.0
kind load docker-image docker.artifactory.magmacore.org/controller:1.5.0
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

Install postgresql and mysql:
```bash
helm install mysql bitnami/mysql \
  --set auth.rootPassword=password

helm install postgresql bitnami/postgresql \
  --set postgresqlPassword=postgres \
  --set postgresqlDatabase=magma \
  --set fullnameOverride=postgresql
```

create a soft-link for orc8rlib:
```bash
export MAGMA_ROOT=$PWD
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

update schema for magma:
```bash
kubectl exec -it mysql-0 -- mysql -u root --password=password < db_setup.sql
```

install orc8r and NMS:
```bash
helm install orc8r .
```

create new user:
```bash
export ORC_POD=$(kubectl get pod -l app.kubernetes.io/component=orchestrator -o jsonpath='{.items[0].metadata.name}')
export NMS_POD=$(kubectl get pod -l app.kubernetes.io/component=magmalte -o jsonpath='{.items[0].metadata.name}')

kubectl exec -it ${ORC_POD} -- envdir /var/opt/magma/envdir /var/opt/magma/bin/accessc add-existing -admin -cert /var/opt/magma/certs/admin-operator/tls.crt admin_operator
kubectl exec -it ${NMS_POD} -- yarn setAdminPassword master admin admin
```

install lte network:
```bash
cd ${MAGMA_ROOT}/lte/cloud/helm/lte-orc8r
mkdir -p charts
ln -s ${MAGMA_ROOT}/orc8r/cloud/helm/orc8rlib charts/orc8rlib

helm upgrade -i lte-orc8r . \
  --set controller.image.repository=magmacore/controller \
  --set controller.image.tag=1.4.0
```

