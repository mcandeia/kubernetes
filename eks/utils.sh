#!/bin/bash

function cluster_services() {
    kubectl get service --all-namespaces
}

function cluster_conf() {
    kubectl cluster-config
    kubectl config view
}

function autoscaler_logs() {
    kubectl -n kube-system logs -f deployment.apps/cluster-autoscaler
}

function deploy_ppp() {
    kubectl create -f tekton-pipelines/04-run/01-ppp-grpc-pipeline-run.yaml
}

function port_forward() {
    kubectl port-forward ppp-grpc-6f547f79cb-7479x 10000
}

function nginx_logs() {
    kubectl logs -f ingress-nginx-controller-df547d78c-s6s2b -n ingress-nginx
}

function nginx_portforward() {
    kubectl port-forward -n ingress-nginx ingress-nginx-controller-df547d78c-s6s2b 8181:80
}
$1 "$@"