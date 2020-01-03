# Lab 2 - Deploying a standalone application as a service
Goal of this lab is to deploy a standalone application on kubernetes and expose it as a service to external world. For this purpose, we are going to use ngnix. [Ngnix!](https://en.wikipedia.org/wiki/Nginx) is an opensource webserver/reserver proxy. 

## Getting Started

Follow the instructions step and by step and do let instructors know if you face any difficulty. 

## Prerequisites

Lab1

## Create a deployment

Kubernetes resources are created in a declarative way using yaml files. Each resource has a configuration yaml file that allows user to specify different parameters within a resource. 
For please take 5 mins to go through this link -> https://developer.ibm.com/tutorials/yaml-basics-and-usage-in-kubernetes/ 

1. Create the ngnix deployment configuration file `ngnix-deployment.yaml`. Open your favorite editor and copy paste the following. Take a moment to read different keys and values. 

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-test-deployment
  labels:
    app: nginx-test
spec:
  selector:
    matchLabels:
      app: nginx-test
  template:
    metadata:
      labels:
        app: nginx-test
    spec:
      containers:
      - name: nginx-test
        image: nginx:latest
        ports:
        - containerPort: 80
```
2. Create a deployment. 

```
kubectl apply -f ngnix-deployment.yaml
```

You should expect the following output 

```
$ kubectl apply -f ngnix-deployment.yaml 
deployment.apps/nginx-test-deployment created

```
3. Check if the deployment is created 

```
$ kubectl get deployment
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
nginx-test-deployment   1/1     1            1           2m
```

4. Check if the pod is created 
```
$ kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
nginx-test-deployment-56d4bb4855-kkbxb   1/1     Running   0          2m4s
```

**Congratulations! You have successfully deployed your first pod to kubernetes cluster.** 

## Create a service

Now that we are successfully deployed a pod to kubernetes cluster, we need to expose it as a service to the external world. For now it is only accessible within the cluster. 
For this purpose, we are going to expose this deployment as a service. This service then be accessible from outside the cluster (i.e. your browser). 

1. Run the following command to expose it as a service: 

```
$ kubectl expose deployment nginx-test-deployment --type=NodePort
```
 
You should expect the following output 
```
service/nginx-test-deployment exposed
```

2. Let's validate further by checking the service status. 

```
$ kubectl get services
```
Do you see the service listed there? Yes?  

```
$ kubectl get services
NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes              ClusterIP   10.96.0.1       <none>        443/TCP        23h
nginx-test-deployment   NodePort    10.96.147.161   <none>        80:31171/TCP   53s
``` 

3. Now let's try to access it. We still don't know the URL to this service. Run the following command 

```
$ minikube service nginx-test-deployment --url
```
You should see a URL in output. Visit this URL in your browser. And you should see the ngnix welcome page! 

## Dashboard

What we have done until now can also be done using the dashboard.  
Run the following command:

```
$ minikube dashboard
```
It should open up the dashboard in your default browser. 

**Excercise following:**
1. How many nodes do you have in your cluster?
2. What namespace are you operating in?
4. Find out events for pod/deployment/service you just crearted. 
5. Find out logs of your service. 


## Deleting the deployment and service 

1. Checkout the relevant ngnix deployment and service. Run the following command the fetch all the resources. 
```
$ kubectl get all
```
Do you see your deployment and service listed here? 

```
NAME                                         READY   STATUS    RESTARTS   AGE
pod/nginx-test-deployment-56d4bb4855-kkbxb   1/1     Running   0          42m

NAME                            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes              ClusterIP   10.96.0.1       <none>        443/TCP        24h
service/nginx-test-deployment   NodePort    10.96.147.161   <none>        80:31171/TCP   36m

NAME                                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-test-deployment   1/1     1            1           42m

NAME                                               DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-test-deployment-56d4bb4855   1         1         1       42m
```

2. To delete it, run the following command
```
$ kubectl delete deployment.apps/nginx-test-deployment service/nginx-test-deployment
```

3. Check if ngnix deployment or service exist. 
```
$ kubectl get all
```

##That's it. You have managed to create a deployment and expose it as a service. You have also managed to bring down the application by deleting the deployment and the service. 

For later: Run other standalone applications on kubernetes. 










