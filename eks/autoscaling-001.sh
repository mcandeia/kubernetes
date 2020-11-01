#!/bin/bash


### Configure autoscaling
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml

kubectl -n kube-system annotate deployment.apps/cluster-autoscaler cluster-autoscaler.kubernetes.io/safe-to-evict="false"


### Here you need to set <YOUR-CLUSTER-NAME> replace to `candy-services`
### See more on https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html
kubectl -n kube-system edit deployment.apps/cluster-autoscaler

### Trouble shooting:
## Need to change manually autoscaling IAM role

kubectl -n kube-system set image deployment.apps/cluster-autoscaler cluster-autoscaler=us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler:v1.18.2
