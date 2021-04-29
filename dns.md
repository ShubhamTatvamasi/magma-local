# Setup DNS

These are the services that came with LoadBalancer

Service | DNS Entry
---|---
nginx-proxy | master.nms.magma
nginx-proxy | magma-test.nms.magma
orc8r-nginx-proxy | api.magma
orc8r-clientcert-nginx | controller.magma
bootstrapper-orc8r-nginx | bootstrapper-controller.magma
fluentd | fluentd.magma


Update your local IPs
```bash
sudo vim /etc/hosts
```

Magma domains:
```
172.22.255.202 master.nms.magma
172.22.255.202 magma-test.nms.magma
172.22.255.203 bootstrapper-controller.magma
172.22.255.201 controller.magma
172.22.255.200 api.magma
```

