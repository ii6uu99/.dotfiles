# Kubernetes tips

## App Engine

```
    1  gcloud version
    8  git clone https://github.com/GoogleCloudPlatform/appengine-guestbook-python     
       && cd appengine-guestbook-python     
       && dev_appserver.py ./app.yaml
    9  gcloud app deploy ./index.yaml ./app.yaml
   10  gcloud auth login
   11  gcloud app deploy ./index.yaml ./app.yaml
   12  gcloud app browse
   13  gcloud app logs tail -s default
   21  gcloud app deploy ./index.yaml ./app.yaml
   22  gcloud app logs tail -s default
   28  gcloud compute zones list
   30  gcloud config set compute/zone europe-west2-b
   ```

## Source code and configuration

On GitHub: https://github.com/udacity/ud615

## Installing GO
```
   31  wget https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz
   33  sudo tar -C /usr/local -xzf go1.6.2.linux-amd64.tar.gz
   34  echo "export GOPATH=~/go" >> ~/.bashrc
   35  source ~/.bashrc
   37  go version


   38  mkdir -p $GOPATH/src/github.com/udacity
   39  cd $GOPATH/src/github.com/udacity
   40  git clone https://github.com/udacity/ud615
   64  cd go/src/github.com/udacity/ud615/app/
   67  echo $GOPATH
   88  cd $GOPATH
   89  cd src/github.com/udacity/ud615/kubernetes/
   90  gcloud container clusters create k0
   91  gcloud zones list
   92  gcloud compute zones list
   ```

## Creating a Kubernetes [K8s] cluster on GCE
```
   93  gcloud container clusters create k0 --zone europe-west2-b
   ```

## Creating a POD on K8s
```
   97  cat pods/monolith.yaml
   98  cat pods/healthy-monolith.yaml
  100  cat pods/monolith.yaml
  101  kubectl create -f pods/monolith.yaml
  102  kubectl get pods
  104  kubectl describe pod monolith
  105  kubectl get pods
  ```

### Port forwarding to reach a POD
```
  106  kubectl port-forward monolith 10080:80
  ```

### Creating a Secret set from PEM files
```
  107  kubectl create secret generic tls-certs --from-file=tls
  108  kubectl describe secret tls-certs
  ```

### Creating a ConfigMap from configuration files
```
  110  cat nginx/proxy.conf
  111  kubectl create configmap nginx-proxy-conf --from-file nginx/proxy.conf
  112  kubectl describe configmap nginx-proxy-conf
  ```

### Creating the "Secure" POD using the Secrets and ConfigMap
```
  113  cat pods/secure-monolith.yaml
  114  kubectl create -f pods/secure-monolith.yaml
  115  kubectl get pods secure-monolith
  119  curl --cacert tls/ca.pem -k https://127.0.0.1:10443
  120  kubectl logs -c nginx secure-monolith
  ```

### Creating a K8s Service using Labels

````bash
121  cat services/monolith.yaml
122  kubectl create -f services/monolith.yaml
123  gcloud compute firewall-rules create allow-monolith-nodeport --allow=tcp:31000
124  kubectl get pods -l "app=monolith"
125  kubectl get pods -l "secure=enabled"
127  kubectl describe pods secure-monolith | grep Labels
128  kubectl label pods secure-monolith "secure=enabled"
129  kubectl get pods -l "secure=enabled"
130  kubectl describe pods secure-monolith | grep Labels
131  kubectl describe services monolith
132  kubectl describe pods secure-monolith | grep Labels
133  kubectl get pods -l "secure=enabled"
134  kubectl label pods secure-monolith "secure=enabled"
135  kubectl describe pods secure-monolith
136  kubectl describe services monolith | grep Endpoints
````

### Contacting the service externally from the internet...

````bash
gcloud compute instances list 
curl -k https://35.189.93.198:31000
````

## General Troubleshooting

````bash
kubectl exec monolith --stdin --tty -c monolith /bin/sh
kubectl port-forward secure-monolith 10443:443
kubectl logs monolith
kubectl logs -f monolith
````

## Lesson 4 - Creating Deployments

Deploying the Auth application: `deployments/auth.yml`

````yaml
apiVersion: extensions/v1beta1
kind: Deployment # The Kubernetes construct this file describes - a Deployment.
metadata:
  name: auth # The deployment name.
spec:
  replicas: 1 # Number of desired replica's.
  template:
    metadata:
      labels:
        app: auth
        track: stable
    spec:
      containers:
        - name: auth
          image: "udacity/example-auth:1.0.0"
          ports:
            - name: http
              containerPort: 80
            - name: health
              containerPort: 81 # The health port.
          resources:
            limits:
              cpu: 0.2
              memory: "10Mi"
          livenessProbe: # Used to establish ongoing container health.
            httpGet:
              path: /healthz
              port: 81
              scheme: HTTP
            initialDelaySeconds: 5
            periodSeconds: 15
            timeoutSeconds: 5
          readinessProbe: # Used to establish the container readyness.
            httpGet:
              path: /readiness
              port: 81
              scheme: HTTP
            initialDelaySeconds: 5
            timeoutSeconds: 1
````

````bash
$ kubectl create -f deployments/auth.yml
$ kubectl describe deployments auth
````

Exposing the Auth service: `services/auth.yaml`.

````yaml
kind: Service # The Kubernetes construct this file describes - a Service.
apiVersion: v1
metadata:
  name: "auth" # The service name.
spec:
  selector:
    app: "auth"
  ports:
    - protocol: "TCP"
      port: 80 # The port to expose the service on.
      targetPort: 80 # The underlying pod port to map requests to.
````

````bash
$ kubectl create -f services/auth.yaml
$ kubectl describe service auth
````

Deploying the Hello service: `deployments/hello.yaml` & `services/hello.yaml`.

````bash
$ kubectl create -f deployments/hello.yaml
$ kubectl create -f services/hello.yaml
````

Deploying the Frontend components: `nginx/frontend.conf`, `deployments/frontend.yaml` and `services/frontend.yaml`.

nginx/frontend.conf

````json
upstream hello {
    server hello.default.svc.cluster.local;
}

upstream auth {
    server auth.default.svc.cluster.local;
}

server {
    listen 443;
    ssl    on;

    ssl_certificate     /etc/tls/cert.pem;
    ssl_certificate_key /etc/tls/key.pem;

    location / {
        proxy_pass http://hello;
    }

    location /login {
        proxy_pass http://auth;
    }
}
````

````bash
$ kubectl create configmap nginx-frontend-conf --from-file=nginx/frontend.conf
$ kubectl create -f deployments/frontend.yaml
$ kubectl create -f services/frontend.yaml
````

Interact with the Frontend application by getting its external IP...

````bash
$ kubectl get services frontend
$ curl -k https://<external-ip>
````

## Lesson 4 - Scaling

