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

Install mysql and postgresql:
```bash
helm install mysql bitnami/mysql \
  --set auth.rootPassword=password \
  --set primary.livenessProbe.enabled=false \
  --set primary.readinessProbe.enabled=false

helm install postgresql bitnami/postgresql \
  --set postgresqlPassword=postgres \
  --set postgresqlDatabase=magma \
  --set livenessProbe.enabled=false \
  --set readinessProbe.enabled=false
```

update schema for magma:
```bash
kubectl exec -it mysql-0 -- mysql -u root --password=password < db_setup.sql
```
