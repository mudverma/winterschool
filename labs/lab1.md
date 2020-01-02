# Goal of this lab is to setup kubernetes cluster locally for application development. 
For this purpose we are going to use "minikube". Minikube implements a local Kubernetes cluster on macOS, Linux, and Windows for local application development. It supports most of the native kubernates functions.  


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

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```
