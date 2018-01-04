kubernetes相关的工具

kubectl

简单概述简单描述描述
http://kubernetes.io/docs/user-guide/kubectl-overview/

泊坞窗图片

https://hub.docker.com/r/pottava/kubectl/

的请立即获取iTunes的标签状语从句：的相应Dockerfile链接

·最新（kubectl / versions / 1.5 / Dockerfile）
·1.5（kubectl / versions / 1.5 / Dockerfile）

用法

alias kubectl="docker run --rm -it -v $HOME/.kube/:/root/.kube/ pottava/kubectl"
kubectl version
kubectl get pods
KOPS

简单概述简单描述描述
https://github.com/kubernetes/kops

泊坞窗图片

https://hub.docker.com/r/pottava/kops/

的请立即获取iTunes的标签状语从句：的相应Dockerfile链接

·最新版（kops / versions / 1.4 / Dockerfile）
·1.4（kops / versions / 1.4 / Dockerfile）

用法

alias kops="docker run --rm -it -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION -e KOPS_STATE_STORE pottava/kops"
kops version

export CLUSTER_NAME=my-cluster.k8s.com
export KOPS_STATE_STORE=s3://k8s-com-state-store
export AWS_DEFAULT_REGION=us-east-1
export AWS_ACCESS_KEY_ID=xxx
export AWS_SECRET_ACCESS_KEY=yyy

docker run --rm -it \
    -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION -e KOPS_STATE_STORE \
    -v `pwd`/id_rsa.pub:/tmp/id_rsa.pub -v `pwd`/out/:/out/ -v $HOME/.kube/:/root/.kube/ \
    pottava/kops create cluster --target=terraform --ssh-public-key=/tmp/id_rsa.pub $CLUSTER_NAME
