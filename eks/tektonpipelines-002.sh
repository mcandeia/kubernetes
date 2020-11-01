#!/bin/bash

## Apply tekton pipelines
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.11.1/release.yaml

## Installing tekton pipeline cli
brew install tektoncd-cli


### Added tekton dashboard
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/tekton-dashboard-release.yaml

### Add git clone task
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/git/git-clone.yaml

### Add build docker image task
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/v1beta1/kaniko/kaniko.yaml

### Added deploy using kubectl task
kubectl apply -f tekton/tasks/deploy-using-kubectl.yaml

### Added build-and-deploy pipeline
kubectl apply -f tekton/pipeline/build-and-deploy-pipeline.yaml


