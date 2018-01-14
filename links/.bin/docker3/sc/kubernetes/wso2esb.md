# Hosting WSO2 ESB 4.9.0 on Kubernetes

Notes taken while pushing to Minikube.

## Setting up the environment.

Setting up the environment to build the images and add them to the Docker library being used by Minikube...

````bash
$ minikube start --vm-driver=xhyve #1
$ eval $(minikube docker-env) #2
```` 

1. I had to do this, otherwise Minikube would silently fail to find the Docker images.
2. This sets up the terminal ENV to contain some Docker VAR's, like the local Docker host.

## Getting the WSO2 Docker build scripts.

Because of Java SDK restrictions, you have to build the images yourself, they aren't on Docker hub. You can Use the scripts provided by WSO2 and follow the blog post [here.](https://medium.com/@pubudu538/run-wso2-esb-in-docker-in-5-minutes-d0a97920b696)

````bash
$ git clone https://github.com/wso2/dockerfiles.git
$ cd dockerfiles
$ git checkout v1.2.0
````

## Building the WSO2 ESB images. 

The WSO2 scripts needed some small modifications in order to work... 

1. The version of Java used in the scripts is 1.7 but this is no longer available, so I changed it to 1.8.
2. The scripts also check the version of Docker used is 1.x but Docker changed versioning scheme, so now its 17.x not 1.x, so I just disabled the version check.
3. The WSO2 ESB Zip and Java Gz files need adding to the scripts common folder as per the instructions.

The first thing to do after these tasks is to build the wso2 "base" image...

````bash
$ ./build.sh
````

Then build the WSO2 ESB image...

````bash
$ ./wso2esb/build.sh -v 4.9.0 
````

This will add the images it builds to the local Docker library of images that is being used by Minikube (if you followed the instructions on how to start and set up the env above).

## Running WSO2 ESB on Minikube.

Once the images are built by the Minikube/Docker you can create a deployment.

````bash
$ kubectl run wso2esb --image=wso2esb:4.9.0 --port=9443 #1
$ kubectl expose deployment wso2esb --type=LoadBalancer --port=8080 --target-port=9443 #2
$ minikube service wso2esb #3
$ minikube dashboard #4
$ kubectl get pods #5
$ kubectl logs <pod-unique-name> #6
````

1. Asks Minikube to run the wso2esb:4.9.0 image (also creates a Kubernetes "deployment" and a "pod" called "wso2esb")
2. Asked Minikube to expose the ESB's console on port 9443 as a service.
3. Asks Minikube to boot a browser and point it to the service.
4. See what Minikube has deployed.
5. Get the list of Pods.
6. Get the logs for a specific pod (needs pod's unique name).


If all that worked, you should see the console window from the WSO2 ESB. 
You can login with username: admin, password: admin.

> Note: This is really rough hacking. This isn't meant to be production ready, it was just to see if it was possible to get a basic and reasonable looking response from hosting the wso2esb image. As it stands, it looks like it's possible to login and add stuff to the ESB config, but I'm not a user of WSO2 so I have no idea if it will work properly.

## Cleaning up.

````bash
$ kubectl delete service wso2esb
$ kubectl delete deployment wso2esb
$ minikube stop
````

To purge the Docker images etc. use the purge scripts in the docker folder in this repo.
