# Install prerequisites

Add helm repos:
```bash
# add helm repo for cert-manager
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add jetstack https://charts.jetstack.io
helm repo update
```

Install cert-manager:
```bash
helm install cert-manager jetstack/cert-manager \
  --create-namespace \
  --namespace cert-manager \
  --set installCRDs=true
```

create new namespace:
```bash
kubectl create ns orc8r

# switch namespace to orc8r
kubens orc8r
```

Install postgresql:
```bash
helm install postgresql bitnami/postgresql \
  --set postgresqlPassword=postgres \
  --set postgresqlDatabase=magma \
  --set livenessProbe.enabled=false \
  --set readinessProbe.enabled=false
```
