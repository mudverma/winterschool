# Lab 1 - Setting up Kubernetes
Goal of this lab is to setup kubernetes cluster locally for application development. For this purpose we are going to use "minikube". Minikube that implements a local Kubernetes cluster on macOS, Linux, and Windows. It supports most of the native kubernates functions.

## Getting Started

These instructions will get you Kubernetes cluster up and running on your local machine for development and testing purposes. 

## Prerequisites

Virtualisation support your system. 

### Linux
    To check if virtualization is supported on Linux, run the following command and verify that the output is non-empty:
```
grep -E --color 'vmx|svm' /proc/cpuinfo
```
### MacOS
To check if virtualization is supported on macOS, run the following command on your terminal.
```
sysctl -a | grep -E --color 'machdep.cpu.features|VMX' 
```
If you see VMX in the output (should be colored), the VT-x feature is enabled in your machine.

### Windows 

TODO

## Installing

### Linux

1. Get the minikube binary 
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```
2. Install The Kubectl Command-Line Tool
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

### MacOS
1. Get the minikube binary 
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
```
2. Install The Kubectl Command-Line Tool
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```
### Windows 

TODO

## Test the installation (For all)

1. Start minikube 
```
minikube start
```

2. Once minikube start finishes, run the command below to check the status of the cluster:
```
minikube status
```

3. If your cluster is running, the output from minikube status should be similar to:
```
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

## Observe Kubernetes functions using kubectl command line tool 

1. Check that kubectl is  installed and configured by running the ```kubectl cluster-info``` command


2. Check the nodes by running ```kubectl get nodes```


3. To get detailed information of a node run ```kubectl describe node```

Note: Observe the output of each command carefully and correlate it with some of the components described during the class. 
