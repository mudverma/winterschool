#!/bin/bash
kubectl apply -f deploy-acmeair-mainservice-java.yaml
kubectl apply -f deploy-acmeair-authservice-java.yaml
kubectl apply -f deploy-acmeair-bookingservice-java.yaml
kubectl apply -f deploy-acmeair-customerservice-java.yaml
kubectl apply -f deploy-acmeair-flightservice-java.yaml

kubectl apply -f  acmeair-authservice-ingress.yaml
kubectl apply -f  acmeair-mainservice-ingress.yaml
kubectl apply -f  acmeair-bookingservice-ingress.yaml
kubectl apply -f  acmeair-customerservice-ingress.yaml
kubectl apply -f  acmeair-flightservice-ingress.yaml
