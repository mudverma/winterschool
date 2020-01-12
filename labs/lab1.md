# Lab 1 - Setting up Kubernetes
Goal of this lab is to learn setting up a local kubernetes cluster for application development. For this purpose we are going to use "minikube". Minikube implements a local Kubernetes cluster on macOS, Linux, and Windows. It supports most of the native kubernates functions.

## Getting Started

These instructions will get your Kubernetes cluster up and running on your local machine for development and testing purposes. 

## Prerequisites

1. Virtualisation support in your system. 

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


2. Install git and curl - Ignore if already done. 

```
sudo apt-get install git  OR sudo yum install git

```
Curl

```
sudo apt-get install curl  OR sudo yum install curl

```

3. Install docker to your system  - Ignore if already installed

```
wget -qO- https://get.docker.com/ | sh
```

## Installing Kubernetes 

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
## Start Minikube

1. Start minikube 
```
minikube start --vm-driver=none --cpus 4 --memory 8192
```
Note: Adjust CPU and memory depending on your hardware capabilities. 

## Not able to install? 
For those who are not able to install minikube or do not have right hardware support should click the following link and find **launch cluster** button. 

https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/

A terminal shall be opened. Maximise it. 

You would be  skipping the immediate next step. 


## Test the installation (For all)


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

1. **Check that kubectl is  installed and configured by running the ```kubectl cluster-info``` command**

Output Example: 
```
$ kubectl cluster-info
Kubernetes master is running at https://x.x.x.x:8443
KubeDNS is running at https://x.x.x.x:8443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

2. **Check the nodes by running ```kubectl get nodes```**

Output Example:
```
$ kubectl get nodes
NAME       STATUS   ROLES    AGE    VERSION
minikube   Ready    master   147m   v1.15.0
```
Notice that it only has one node running. 

3. **To get detailed information of a node run ```kubectl describe node```**

Output Example:
```
$ kubectl describe node
Name:               minikube
Roles:              master
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=minikube
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/master=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: /var/run/dockershim.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Thu, 02 Jan 2020 15:58:59 +0530
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  minikube
  AcquireTime:     <unset>
  RenewTime:       Thu, 02 Jan 2020 18:26:47 +0530
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Thu, 02 Jan 2020 18:26:34 +0530   Thu, 02 Jan 2020 15:58:55 +0530   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Thu, 02 Jan 2020 18:26:34 +0530   Thu, 02 Jan 2020 15:58:55 +0530   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Thu, 02 Jan 2020 18:26:34 +0530   Thu, 02 Jan 2020 15:58:55 +0530   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Thu, 02 Jan 2020 18:26:34 +0530   Thu, 02 Jan 2020 15:58:55 +0530   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.168.64.2
  Hostname:    minikube
Capacity:
  cpu:                2
  ephemeral-storage:  16954240Ki
  hugepages-2Mi:      0
  memory:             1986656Ki
  pods:               110
Allocatable:
  cpu:                2
  ephemeral-storage:  16954240Ki
  hugepages-2Mi:      0
  memory:             1986656Ki
  pods:               110
System Info:
  Machine ID:                 93d5f980480c4d05a40be7afe472d530
  System UUID:                506a11ea-0000-0000-994e-acde48001122
  Boot ID:                    c0145c0d-fc76-4440-b5f9-7015b778e0ad
  Kernel Version:             4.19.81
  OS Image:                   Buildroot 2019.02.7
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  docker://19.3.5
  Kubelet Version:            v1.15.0
  Kube-Proxy Version:         v1.15.0
Non-terminated Pods:          (11 in total)
  Namespace                   Name                                          CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                   ----                                          ------------  ----------  ---------------  -------------  ---
  kube-system                 coredns-5c98db65d4-plskn                      100m (5%)     0 (0%)      70Mi (3%)        170Mi (8%)     147m
  kube-system                 coredns-5c98db65d4-wgzrq                      100m (5%)     0 (0%)      70Mi (3%)        170Mi (8%)     147m
  kube-system                 etcd-minikube                                 0 (0%)        0 (0%)      0 (0%)           0 (0%)         146m
  kube-system                 kube-addon-manager-minikube                   5m (0%)       0 (0%)      50Mi (2%)        0 (0%)         146m
  kube-system                 kube-apiserver-minikube                       250m (12%)    0 (0%)      0 (0%)           0 (0%)         146m
  kube-system                 kube-controller-manager-minikube              200m (10%)    0 (0%)      0 (0%)           0 (0%)         146m
  kube-system                 kube-proxy-mhtgp                              0 (0%)        0 (0%)      0 (0%)           0 (0%)         147m
  kube-system                 kube-scheduler-minikube                       100m (5%)     0 (0%)      0 (0%)           0 (0%)         146m
  kube-system                 storage-provisioner                           0 (0%)        0 (0%)      0 (0%)           0 (0%)         147m
  kubernetes-dashboard        dashboard-metrics-scraper-74c99fbfdf-kk6dp    0 (0%)        0 (0%)      0 (0%)           0 (0%)         45m
  kubernetes-dashboard        kubernetes-dashboard-86d44f77cf-92wwh         0 (0%)        0 (0%)      0 (0%)           0 (0%)         45m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                755m (37%)  0 (0%)
  memory             190Mi (9%)  340Mi (17%)
  ephemeral-storage  0 (0%)      0 (0%)
Events:              <none>
```

Note: Observe the output of each command carefully and correlate it with some of the components described during the class. 



## Download artefacts for next labs

github.com/mudverma/winterschool

```
git clone https://github.com/mudverma/winterschool.git
```


# Congratulations! You have successfully setup a single node local Kubernetes environment. In next lab we would try to deploy a single container application. 
