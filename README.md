# jenkins-docker
![example workflow](https://github.com/mallond/jenkins-docker/actions/workflows/dockerpush.yml/badge.svg)

```
kubectl create namespace jenkins
```
```
kubectl create -f https://raw.githubusercontent.com/mallond/jenkins-docker/main/deployment.yaml -n jenkins
```
```
kubectl create -f https://raw.githubusercontent.com/mallond/jenkins-docker/main/service.yaml -n jenkins
```
```
kubectl patch svc jenkins -n jenkins -p '{"spec": {"type": "LoadBalancer", "externalIPs":["172.21.23.191"]}}'
```
```
kubectl get pods -n jenkins
kubectl logs <pod_name> -n jenkins
out: Copy passowrd to be used to do the initial install
```
