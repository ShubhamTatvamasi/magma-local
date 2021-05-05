# setup AGW

Download rootCA.pem 
```bash
kubectl get secrets orc8r-root-tls \
  -o jsonpath='{.data.tls\.crt}' | base64 -d > rootCA.pem
```

```bash
kubectl get secrets orc8r-admin-operator-tls \
  -o jsonpath='{.data.keystore\.p12}' | base64 -d > admin_operator.pfx
```

https://api.magma/swagger/v1/ui/

