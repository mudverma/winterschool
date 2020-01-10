#!/bin/bash
kubectl delete -f deploy-acmeair-mainservice-java.yaml
kubectl delete -f deploy-acmeair-authservice-java.yaml
kubectl delete -f deploy-acmeair-bookingservice-java.yaml
kubectl delete -f deploy-acmeair-customerservice-java.yaml
kubectl delete -f deploy-acmeair-flightservice-java.yaml
kubectl delete -f  acmeair-authservice-ingress.yaml
kubectl delete -f  acmeair-mainservice-ingress.yaml
kubectl delete -f  acmeair-bookingservice-ingress.yaml
kubectl delete -f  acmeair-customerservice-ingress.yaml
kubectl delete -f  acmeair-flightservice-ingress.yaml
