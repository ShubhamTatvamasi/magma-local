# extra charts

add repos:
```bash
helm repo add stable https://charts.helm.sh/stable/
helm repo add elastic https://helm.elastic.co
helm repo update
```

For 3 Node cluster just run:
```bash
helm upgrade -i elasticsearch elastic/elasticsearch
```

Install elasticsearch:
```bash
helm upgrade -i elasticsearch elastic/elasticsearch \
  --set replicas=1 \
  --set rbac.create=true \
  --set roles.ml=false \
  --set roles.remote_cluster_client=false \
  --set antiAffinity=soft
```


### Research

Helm Chart | Source
---|---
fluentd | https://github.com/magma/magma/blob/master/orc8r/cloud/deploy/terraform/orc8r-helm-aws/logging.tf
elasticsearch | https://github.com/magma/magma/blob/master/orc8r/cloud/deploy/terraform/orc8r-aws/efk.tf


### OLD

install fluentd:
```bash
helm upgrade -i fluentd stable/fluentd -f fluentd.yaml
```

install elasticsearch:
```bash
helm upgrade -i elasticsearch-master elastic/elasticsearch \
  -f elasticsearch-master.yaml

helm upgrade -i elasticsearch-data elastic/elasticsearch \
  -f elasticsearch-data.yaml

helm upgrade -i elasticsearch-data2 elastic/elasticsearch \
  -f elasticsearch-data2.yaml

helm upgrade -i elasticsearch-curator stable/elasticsearch-curator \
  -f elasticsearch-curator.yaml
```

install kibana:
```bash
helm upgrade -i kibana stable/kibana -f kibana.yaml
```
