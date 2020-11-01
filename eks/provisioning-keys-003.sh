#!/bin/bash

### Create am IAM role with ECR access
ACCESS_KEY=
SECRET_KEY=
kubectl create secret generic registry-secret --type="kubernetes.io/basic-auth" --from-literal=username=$ACCESS_KEY --from-literal=password=$SECRET_KEY

kubectl annotate secret registry-secret tekton.dev/docker-0=462942818386.dkr.ecr.us-east-1.amazonaws.com/ppp-grpc

### Added pipeline account
kubectl apply -f tekton/pipeline-account.yaml

### Added pipeline account
kubectl apply -f tekton/ppp-grpc-pipeline-pvc.yaml

### Create Run task
kubectl create -f tekton/run/ppp-grpc-pipeline-run.yaml