# Lab 3 - Deploying an application consisting of multiple microservices 
Goal of this lab is to deploy a multi container application on kubernetes and expose it as a service to external world. For this purpose, we are going to use Acme-air application. Acme-Air is a fictious airline application consisting of 8 microservices (1 UI, 4 Rest API servers and 3 databases) [Acme-Air!](https://github.com/blueperf/). 

## Topology 

![alt text](https://github.com/blueperf/acmeair-mainservice-java/blob/master/images/AcmeairMS.png "AcmeairMS Java")


## Getting Started

Follow the instructions step and by step and do let instructors know if you face any difficulty. 

## Prerequisites

Lab2

### 1. Cleanup everything (people not using their own machine should skip this step)

See what is there
```
kubectl get all
```
Now delete all the deployments, services, and ingress

```
kubectl delete --all deployment
kubectl delete --all services
kubectl delete --all ingress
kubectl delete --all pvc
kubectl delete namespace winterschool
```


### 2. Add Docker env to minikube 

```
minikube docker-env
eval $(minikube docker-env)

```

##  Acme-Air Deployment 


### 1. Enable Ingress
```
minikube addons enable ingress
```

Output
```
ingress was successfully enabled
```

### 2. Check artefacts 

Go to /script directory of downloaded git repo  
https://github.com/mudverma/winterschool


There are 10 yamls files and 2 shell scripts. Please go through the content of each file and try to correlate it with the theory class. 

```
$ ls
acmeair-authservice-ingress.yaml		
acmeair-flightservice-ingress.yaml		
deploy-acmeair-authservice-java.yaml		
deploy-acmeair-flightservice-java.yaml
acmeair-bookingservice-ingress.yaml		
acmeair-mainservice-ingress.yaml		
deploy-acmeair-bookingservice-java.yaml		
deploy-acmeair-mainservice-java.yaml
acmeair-customerservice-ingress.yaml		
deploy-acmeair-customerservice-java.yaml	
deployToMinikube.sh
deleteAcmeAir.sh
```

A sample deployment configuration for bookingservice and bookingdb is here

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: acmeair-booking-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      name: acmeair-booking-deployment
  template:
    metadata:
      labels:
        name: acmeair-booking-deployment
        service: acmeair-bookingservice
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9080"
    spec:
      containers:
      - name: acmeair-booking-deployment
        image: muditverma/hcwc-bookingservice:latest
        ports:
          - containerPort: 9080
          - containerPort: 9443
        imagePullPolicy: IfNotPresent
        env:
        - name: USERNAME
          value: admin
        - name: PASSWORD
          value: password
        - name: MONGO_HOST
          value: acmeair-booking-db
        - name: JVM_ARGS
          value: "-DcustomerClient/mp-rest/url=http://acmeair-customer-service:9080 -DflightClient/mp-rest/url=http://acmeair-flight-service:9080 -Dmp.jwt.verify.publickey.location=http://acmeair-auth-service:9080/getJwk"
        - name: TRACK_REWARD_MILES
          value: 'true'
        - name: SECURE_SERVICE_CALLS
          value: 'true'
        readinessProbe:
          httpGet:
            path: /health
            port: 9080
          initialDelaySeconds: 10
          periodSeconds: 5
        livenessProbe:
          httpGet:
            path: /health
            port: 9080
          initialDelaySeconds: 120
          periodSeconds: 15
---
apiVersion: v1
kind: Service
metadata:
  name: acmeair-booking-service
  namespace: mudit
spec:
  ports:
    - port: 9080
  selector:
    name: acmeair-booking-deployment
---
##### Booking Database  #####
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    service: acmeair-booking-db
  name: acmeair-booking-db
spec:
  ports:
  - name: "27017"
    port: 27017
    protocol: TCP
    targetPort: 27017
  selector:
    service: acmeair-booking-db
status:
  loadBalancer: {}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  name: acmeair-booking-db
spec:
  replicas: 1
  selector:
    matchLabels:
      service: acmeair-booking-db
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        service: acmeair-booking-db
    spec:
      containers:
      - image: muditverma/hcwc-mongodb:latest
        name: acmeair-booking-db
        ports:
        - containerPort: 27017
          protocol: TCP
        resources: {}
      restartPolicy: Always
status: {}

```

### 3. Deploy the microservices to Kubernetes 

Note: It might take sometime to pull the images from the repos and create pods/containers.  Run the following script 

bash deployToMinikube.sh
```
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
```


Expect to see the following output 
```
deployment.apps/acmeair-main-deployment created
service/acmeair-main-service created
deployment.apps/acmeair-auth-deployment created
service/acmeair-auth-service created
deployment.apps/acmeair-booking-deployment created
service/acmeair-booking-service created
service/acmeair-booking-db created
deployment.apps/acmeair-booking-db created
deployment.apps/acmeair-customer-deployment created
service/acmeair-customer-service created
service/acmeair-customer-db created
deployment.apps/acmeair-customer-db created
deployment.apps/acmeair-flight-deployment created
service/acmeair-flight-service created
service/acmeair-flight-db created
deployment.apps/acmeair-flight-db created
ingress.extensions/acmeair-auth-ingress created
ingress.extensions/acmeair-main-ingress created
ingress.extensions/acmeair-booking-ingress created
ingress.extensions/acmeair-customer-ingress created
ingress.extensions/acmeair-flight-ingress created
```


### 4. Check the status periodically to see the progress 
```
$ kubectl get all
NAME                                              READY   STATUS    RESTARTS   AGE
pod/acmeair-auth-deployment-b696d7cf9-slzrg       1/1     Running   0          27s
pod/acmeair-booking-db-cf5b5d49f-x6znt            1/1     Running   0          27s
pod/acmeair-booking-deployment-665599b6bb-4xb9t   1/1     Running   0          27s
pod/acmeair-customer-db-755b689c79-fgp9z          1/1     Running   0          26s
pod/acmeair-customer-deployment-65f898bf6-p5l22   1/1     Running   0          27s
pod/acmeair-flight-db-55dd58dbc9-p6dkr            1/1     Running   0          26s
pod/acmeair-flight-deployment-69b776b47f-8ldm2    1/1     Running   0          26s
pod/acmeair-main-deployment-646875f86d-gx2n2      1/1     Running   0          27s

NAME                               TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)     AGE
service/acmeair-auth-service       ClusterIP   10.96.87.148    <none>        9080/TCP    27s
service/acmeair-booking-db         ClusterIP   10.96.156.122   <none>        27017/TCP   27s
service/acmeair-booking-service    ClusterIP   10.96.222.146   <none>        9080/TCP    27s
service/acmeair-customer-db        ClusterIP   10.96.76.79     <none>        27017/TCP   26s
service/acmeair-customer-service   ClusterIP   10.96.214.186   <none>        9080/TCP    26s
service/acmeair-flight-db          ClusterIP   10.96.68.33     <none>        27017/TCP   26s
service/acmeair-flight-service     ClusterIP   10.96.156.92    <none>        9080/TCP    26s
service/acmeair-main-service       ClusterIP   10.96.113.177   <none>        9080/TCP    27s
service/kubernetes                 ClusterIP   10.96.0.1       <none>        443/TCP     3m24s

NAME                                          READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/acmeair-auth-deployment       1/1     1            1           27s
deployment.apps/acmeair-booking-db            1/1     1            1           27s
deployment.apps/acmeair-booking-deployment    1/1     1            1           27s
deployment.apps/acmeair-customer-db           1/1     1            1           26s
deployment.apps/acmeair-customer-deployment   1/1     1            1           27s
deployment.apps/acmeair-flight-db             1/1     1            1           26s
deployment.apps/acmeair-flight-deployment     1/1     1            1           26s
deployment.apps/acmeair-main-deployment       1/1     1            1           27s

NAME                                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/acmeair-auth-deployment-b696d7cf9       1         1         1       27s
replicaset.apps/acmeair-booking-db-cf5b5d49f            1         1         1       27s
replicaset.apps/acmeair-booking-deployment-665599b6bb   1         1         1       27s
replicaset.apps/acmeair-customer-db-755b689c79          1         1         1       26s
replicaset.apps/acmeair-customer-deployment-65f898bf6   1         1         1       27s
replicaset.apps/acmeair-flight-db-55dd58dbc9            1         1         1       26s
replicaset.apps/acmeair-flight-deployment-69b776b47f    1         1         1       26s
replicaset.apps/acmeair-main-deployment-646875f86d      1         1         1       27s


```

** Question: What does ingress do here **


### 5. Let's try to access the application
```
minikube ip
```

Let's access the application
```
http://x.x.x.x/acmeair
``` 
