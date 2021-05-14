# Setup kind cluster

start a local kind kubernetes cluster:
```bash
kind create cluster
```

Also enable [LoadBalancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/) for Kind cluster.

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

kind load docker-image docker.artifactory.magmacore.org/nginx:1.5.0
kind load docker-image docker.artifactory.magmacore.org/magmalte:1.5.0
kind load docker-image docker.artifactory.magmacore.org/controller:1.5.0
```

check if all the images are successfully loaded on kind cluster:
```bash
docker exec -it kind-control-plane crictl images
```
> Note: change your container name if it's not `kind-control-plane`

