# Setup kind cluster

start a local kind kubernetes cluster:
```bash
kind create cluster
```

Install Metal LB:
```bash
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml
```

check the IP range for kind docker network:
```bash
docker network inspect -f '{{.IPAM.Config}}' kind
```

Setup address pool:
```yaml
kubectl create -f - << EOF
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.18.255.200-172.18.255.250
EOF
```

download magma docker images:
```bash
docker pull docker.artifactory.magmacore.org/nginx:1.6.1
docker pull docker.artifactory.magmacore.org/magmalte:1.6.1
docker pull docker.artifactory.magmacore.org/controller:1.6.1

docker pull shubhamtatvamasi/nginx:magma-master-certs.0.1.1
```

load magma images on kind:
```bash
kind load docker-image docker.artifactory.magmacore.org/nginx:1.6.1
kind load docker-image docker.artifactory.magmacore.org/magmalte:1.6.1
kind load docker-image docker.artifactory.magmacore.org/controller:1.6.1

kind load docker-image shubhamtatvamasi/nginx:magma-master-certs.0.1.1
```

check if all the images are successfully loaded on kind cluster:
```bash
docker exec -it kind-control-plane crictl images
```
> Note: change your container name if it's not `kind-control-plane`
