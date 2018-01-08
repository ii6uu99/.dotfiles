# Kubernetes Minikube

Minikube is a version of Kubernetes that can be run locally on a developer machine. It requires Docker to run.

https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/

## Installation on Mac OSX...

````bash
$ brew install xhyve
$ curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 &&   \
$ chmod +x minikube && \
$ sudo mv minikube /usr/local/bin/
$ minikube --version
$ brew install docker-machine-driver-xhyve
$ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
$ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
$ brew install kubectl
$ curl --proxy "" https://cloud.google.com/container-registry/
````

That last command should tell you that you can browse the web without a proxy.

# Working with Minikube

Once started, you can try out various Kubernetes `kubectl` commands against your local `minikube` context.
Minikube also has some commands of it's own to make certain tasks simpler, like `minikube service <name>` that
will open a browser pointing to a services local public URL.

## Starting and Stopping Minikube

To start the local Minikube cluster (with Docker running and no need for a http proxy)...

````bash
$ minikube start --vm-driver=xhyve
````

Then set the kubectl context. You can see all your available contexts in the `~/.kube/config` file.

````bash
$ kubectl config use-context minikube
````

Then verify `kubectl` is working with Minikube...

````bash
$ kubectl cluster-info
````

To stop Minikube use...

````bash
$ minikube stop
````

# Running Applications on Minikube 

The `Dockerfile` in this folder packages up the simple Node.js application in `server.js`.

Set the Minikube Docker deamon...

````bash
$ eval $(minikube docker-env) # Use `eval $(minikube docker-env -u)` to reverse this.
````

Build the Docker container...

````bash
$ docker build -t hello-node:v1 .
````

## Create a Deployment

This example is a simple one so it's not using a manifest approach, just manual commands.

Run the container on Kubernetes (creates a deployments and a pod automatically using the name given)...

````bash
$ kubectl run hello-node --image=hello-node:v1 --port=8080
deployment "hello-node" created
````

Show running deployments...

````bash
$ kubectl get deployments

NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
hello-node   1         1         1            1           3m
````

Show running pods...

````bash
$ kubectl get pods

NAME                         READY     STATUS    RESTARTS   AGE
hello-node-714049816-ztzrb   1/1       Running   0          6m
````

Show the Kuberentes events...

````bash
$ kubectl get events

LASTSEEN   FIRSTSEEN   COUNT     NAME                          KIND         SUBOBJECT                     TYPE      REASON                    SOURCE                  MESSAGE
1m         1m          1         hello-node-1038538626-41tk5   Pod                                        Normal    Scheduled                 default-scheduler       Successfully assigned hello-node-1038538626-41tk5 to minikube
1m         1m          1         hello-node-1038538626-41tk5   Pod                                        Normal    SuccessfulMountVolume     kubelet, minikube       MountVolume.SetUp succeeded for volume "default-token-znxhx"
````

Show the Kubernetes configuration...

````bash
$ kubectl config view

apiVersion: v1
clusters:
- cluster:
    certificate-authority: /Users/benwilcock/.minikube/ca.crt
    server: https://192.168.64.2:8443
  name: minikube
contexts:
- context:
    cluster: minikube
    user: minikube
  name: minikube
current-context: minikube
kind: Config
preferences: {}
users:
- name: minikube
  user:
    client-certificate: /Users/benwilcock/.minikube/apiserver.crt
    client-key: /Users/benwilcock/.minikube/apiserver.key
````

## Create a Service

By default, the Pod is only accessible by its internal IP address within the Kubernetes cluster. 
To make the `hello-node` Container accessible from outside the Kubernetes virtual network, 
you have to expose the Pod as a Kubernetes Service...

````bash
$ kubectl expose deployment hello-node --type=LoadBalancer

service "hello-node" exposed

$ kubectl get services

NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)          AGE
hello-node   10.0.0.87    <pending>     8080:32202/TCP   28s
kubernetes   10.0.0.1     <none>        443/TCP          22h
````

The `--type=LoadBalancer` flag indicates that you want to expose your Service outside of the cluster. 
On cloud providers that support load balancers, an external IP address would be provisioned to access the Service. 
On Minikube, the `LoadBalancer` type makes the Service accessible through the `minikube service` command.

````bash
$ minikube service hello-node
````

This automatically opens up a browser window using a local IP address that serves your app and shows the “Hello World” message.

## Updating the Application.

Change the output from "Hello World!" to something else. Now we will rebuild the Docker container image and update 
the deployment in Kubernetes...

````bash
$ docker build -t hello-node:v2
$ kubectl set image deployment/hello-node hello-node=hello-node:v2
````

Refresh the browser or use `minukube service hello-node` to start a fresh tab.

## Cleaning up & removing deployments

Deleting the service and the deployment...

````bash
$ kubectl delete service hello-node
$ kubectl delete deployment hello-node
````
