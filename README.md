# magma-local

## Index

- [Setup local kubernetes cluster](setup-local-kubernetes-cluster)
- [Install prerequisites](install-prerequisites)

### Setup local kubernetes cluster

start a local kind kubernetes cluster:
```bash
kind create cluster
```

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


