# prod steps

give public IP address pool:
```bash
kubectl create -f - << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: address-pool-1
      protocol: layer2
      addresses:
      - 1.1.1.1-8.8.8.8
EOF
```

generate secrets:
```bash
mkdir -p certs && cd certs
../01-generate-secrets.sh magmalocal.com
```

add orc8r secrets repo:
```bash
helm repo add magma-charts-152 https://shubhamtatvamasi.github.io/magma-charts-152
helm repo update
```

create orc8r secret:
```bash
helm template orc8r magma-charts-152/secrets \
  --set secret.certs.enabled=true \
  --set-file secret.certs.files."rootCA\.pem"=rootCA.pem \
  --set-file secret.certs.files."rootCA\.key"=rootCA.key \
  --set-file secret.certs.files."controller\.crt"=controller.crt \
  --set-file secret.certs.files."controller\.key"=controller.key \
  --set-file secret.certs.files."admin_operator\.pem"=admin_operator.pem \
  --set-file secret.certs.files."admin_operator\.pfx"=admin_operator.pfx \
  --set-file secret.certs.files."admin_operator\.key\.pem"=admin_operator.key.pem \
  --set-file secret.certs.files."fluentd\.pem"=fluentd.pem \
  --set-file secret.certs.files."fluentd\.key"=fluentd.key \
  --set-file secret.certs.files."bootstrapper\.key"=bootstrapper.key \
  --set-file secret.certs.files."certifier\.key"=certifier.key \
  --set-file secret.certs.files."certifier\.pem"=certifier.pem \
  --set-file secret.certs.files."nms_nginx\.key\.pem"=nms_nginx.key.pem \
  --set-file secret.certs.files."nms_nginx\.pem"=nms_nginx.pem \
  --set=docker.registry=docker.io \
  --set=docker.username=username \
  --set=docker.password=password |
kubectl apply -f -
```

setup volumes:
```bash
kubectl apply -f volume_claims.yaml
```

add orc8r repo:
```bash
helm repo add orc8r https://artifactory.magmacore.org/artifactory/helm/
helm repo update
```

install orc8r:
```bash
helm upgrade -i orc8r orc8r/orc8r -f values.yaml \
  --version=1.5.23 \
  --set nginx.spec.hostname=controller.magmalocal.com
```

create user:
```bash
ORC_POD=$(kubectl get pod -l app.kubernetes.io/component=orchestrator -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it ${ORC_POD} -- envdir /var/opt/magma/envdir /var/opt/magma/bin/accessc \
  add-existing -admin -cert /var/opt/magma/certs/admin_operator.pem admin_operator

NMS_POD=$(kubectl get pod -l app.kubernetes.io/component=magmalte -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it ${NMS_POD} -- yarn setAdminPassword master admin admin
kubectl exec -it ${NMS_POD} -- yarn setAdminPassword magma-test admin admin
```
