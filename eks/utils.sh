#!/bin/bash

CLUSTER=candeia-services

function init() {
    nginx_pod=$(kubectl get pods -n ingress-nginx | ggrep -oP "ingress-nginx-controller.*" | cut -d " " -f1)
}

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

function deploy() {
    kubectl create -f tekton-pipelines/04-run/01-ppp-grpc-pipeline-run.yaml
}

function port_forward() {
    kubectl port-forward ppp-grpc-56787dfd4f-khp7m 10000
}

function nginx_logs() {
    init
    kubectl logs -f $nginx_pod -n ingress-nginx
}

function nginx_portforward() {
    init
    kubectl port-forward -n ingress-nginx $nginx_pod 8181:80
}

function delete_cluster() {
    eksctl delete cluster --region=us-east-1 --name=$CLUSTER
}

function configure() {
    sed -i '' "s/__CLUSTER_NAME__/$CLUSTER/g" run-once/cluster-conf.yaml
}
function create_cluster() {
    configure
    eksctl create cluster --config-file run-once/cluster-conf.yaml
}

function get_ingress() {
    kubectl describe ingress.networking.k8s.io/ppp-grpc-ingress
}

$1 "$@"