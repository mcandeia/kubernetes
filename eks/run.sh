#!/bin/bash

### PARAMS
REGION=us-east-1
ECR_REPO=462942818386.dkr.ecr.us-east-1.amazonaws.com/ppp-grpc

USERNAME=AWS
PASSWORD=$(aws ecr get-login-password --region $REGION)

### Configure autoscaling
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml

kubectl -n kube-system annotate deployment.apps/cluster-autoscaler cluster-autoscaler.kubernetes.io/safe-to-evict="false"

### Here you need to set <YOUR-CLUSTER-NAME> replace to `CLUSTER`
### See more on https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html

##        - --balance-similar-node-groups
##        - --skip-nodes-with-system-pods=false
kubectl -n kube-system edit deployment.apps/cluster-autoscaler

### Trouble shooting:
## Need to change manually autoscaling IAM role

kubectl -n kube-system set image deployment.apps/cluster-autoscaler cluster-autoscaler=us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler:v1.18.2

## Apply tekton pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.11.1/release.yaml

### Tekton dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml

### Add git clone task
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/git/git-clone.yaml

### Add build docker image task
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/kaniko/kaniko.yaml

### Added deploy using kubectl task
kubectl apply -f tekton-pipelines/01-tasks/01-deploy-using-kubectl.yaml

### Added build-and-deploy pipeline
kubectl apply -f tekton-pipelines/02-pipeline/01-build-and-deploy-pipeline.yaml

### Create secret to access ECR
kubectl create secret generic registry-secret --type="kubernetes.io/basic-auth" --from-literal=username=$USERNAME --from-literal=password=$PASSWORD

kubectl annotate secret registry-secret tekton.dev/docker-0=$ECR_REPO

### Added pipeline account
kubectl apply -f tekton-pipelines/03-service/01-pipeline-account.yaml

### Added pipeline account
kubectl apply -f tekton-pipelines/03-service/02-pipeline-pvc.yaml

### NGINX Ingress Controller

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.40.2/deploy/static/provider/aws/deploy.yaml

### Create Run task
## kubectl create -f tekton-pipelines/04-run/01-ppp-grpc-pipeline-run.yaml

### Add linkerd
linkerd install | kubectl apply -f -

linkerd -n linkerd top deploy/linkerd-web
