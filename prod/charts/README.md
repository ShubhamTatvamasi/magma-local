# extra charts

add repos:
```bash
helm repo add stable https://charts.helm.sh/stable/
helm repo add elastic https://helm.elastic.co
helm repo update
```

install fluentd:
```bash
cat fluentd.yaml | \
  sed 's/fluentd.magmalocal.com/fluentd.prod.magmalocal.com/' | \
  helm upgrade -i fluentd stable/fluentd -f -
```

install elasticsearch:
```bash
cat elasticsearch-master.yaml | \
  sed 's/elasticsearch.magmalocal.com/elasticsearch.prod.magmalocal.com/' | \
  helm upgrade -i elasticsearch-master elastic/elasticsearch -f -

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
