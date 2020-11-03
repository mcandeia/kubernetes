#!/bin/bash

DOMAIN=marcos-candeia.com
PREFIX=candeia
KEY=grpc-key
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $PREFIX.key -out $PREFIX.crt -subj "/CN=$DOMAIN/O=$DOMAIN"

kubectl create secret tls $KEY --key $PREFIX.key --cert $PREFIX.crt

### Apply nginx rule
kubectl apply -f nginx/01-grpc-ingress.yaml
