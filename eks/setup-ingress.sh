#!/bin/bash

DOMAIN=acbe3de6510a643be915fb9b4689da2f-93a02eb91d8f20c6.elb.us-east-1.amazonaws.com
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=$DOMAIN/O=$DOMAIN"
kubectl create secret tls elb-tls --key tls.key --cert tls.crt
### Apply nginx rule

kubectl apply -f nginx/01-grpc-ingress.yaml

