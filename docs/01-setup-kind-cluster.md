# Setup kind cluster

start a local kind kubernetes cluster:
```bash
kind create cluster
```

Also enable [LoadBalancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/) for Kind cluster.

download magma docker images:
```bash
docker pull magmacore/nginx:1.6.1
docker pull magmacore/magmalte:1.6.1
docker pull magmacore/controller:1.6.1

docker pull shubhamtatvamasi/nginx:magma-master-certs.0.1.1
```

load magma images on kind:
```bash
kind load docker-image magmacore/nginx:1.6.1
kind load docker-image magmacore/magmalte:1.6.1
kind load docker-image magmacore/controller:1.6.1

kind load docker-image shubhamtatvamasi/nginx:magma-master-certs.0.1.1
```

check if all the images are successfully loaded on kind cluster:
```bash
docker exec -it kind-control-plane crictl images
```
> Note: change your container name if it's not `kind-control-plane`

