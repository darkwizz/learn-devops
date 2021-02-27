# Short k8s Notes

### Use minikube with Docker driver

```bash
$ minikube start --driver=docker
```

- or to make it the default driver

```bash
$ minikube config set driver docker
```

- to run with logs:
```bash
$ minikube start ... --alsologtostderr -v=<level>
```

### Installation stuff

if to install `docker` with `snap` then `minikube start` won't run properly. Should be installed manually with `apt` or with the installation `.sh` file


### Bash complete
```bash
$ kubectl complete bash > /etc/bash_completion.d/kubectl
$ exec bash  # to apply changes in the current shell
```


### Commands

* Create a deployment:
```bash
$ kubectl create deployment first-dep-ever --image=busybox --port=5071 --replicas=2
```
or
```bash
$ kubectl create deployment nginx-dep --image=nginx --port=80
```
![pods](resources/kubectl-pods-replicasets.png)
_podId_ is created from its deplyoment name, id of the replicaset and its own id


#### **CrashLoopBackOff**

when starting a deployment (which also means running pods), something like this may appear:
![CrashLoopBackOff pods](resources/crashloopbackoff-pods.png)

The state itself means that a pod keeps starting, crashing and starting all the time. At least according to the default `Always` of `restartPolicy` (the other options are `OnFailure` and `Never`), which can be specified in `PodSpec`:
```yaml
apiVersion: v1
kind: pod
metadata:
  name: some-pod
spec:
  containers:
    - name: some-pod
      image: ubuntu
  restartPolicy: Always
```
this can be edited (among the other ways) by running `kubectl edit`
```bash
$ kubectl edit pod <pod-id>
```
> or the same change can be made for a whole deployment

but in this specific case the issue happened because the image which was used for the deployment `first-dep-ever` does not have any command and just starts, immediately finishes its work and restarts again.

#### Debugging
```bash
$ kubectl describe <pod-name>
```

```bash
$ kubectl logs <pod-name>
```

```bash
$ kubectl exec -it <pod-name> -- <shell>
```