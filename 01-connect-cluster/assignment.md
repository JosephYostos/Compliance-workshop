---
slug: connect-cluster
id: etaqqcwy4j0g
type: challenge
title: Connect Kubernetes cluster to Calico Cloud
teaser: secure your clusetr in 5 minutes
notes:
- type: video
  url: ../assets/Compliance.mp4
- type: text
  contents: |-
    This track uses a two node Kubernetes cluster on a sandbox virtual machine.
    Please wait while we boot the VM for you and start Kubernetes.

    ## Objectives

    In this track, this is what you'll learn:
    - Design and build calico security policies
    - Advanced reporting and visibility
    - End-to-end encryption
tabs:
- title: Shell
  type: terminal
  hostname: controlplane
- title: Calico Cloud
  type: website
  hostname: controlplane
  url: https://www.calicocloud.io/home
  new_window: true
difficulty: basic
timelimit: 12000
---
Create Calico Cloud trial account and login
===============

Use the calico cloud tab to sign up for a 14 day trial account :

<img src="https://github.com/JosephYostos/kubeadm-installation/blob/main/login.png?raw=true" alt="login" width="100%"/>

Once you activate your account with your email, login to calico cloud using the same tab

Install calico cloud
===============
Click the "Managed Cluster" in your left side of browser.

![Image Description](../assets/managed-cluster.png)

Click on "connect cluster"

![Image Description](../assets/connect-cluster.png)

Enter a name to your cluster, choose kubeadm and click next

![Image Description](../assets/choose-kubeadm.png)

Copy the installation script and use the terminal tab to run it in your cluster

![Image Description](../assets/script.png)

🚀 Validate what we have done
==============

Use the terminal to check the calico cloud instalation status:

```
kubectl get installer default --namespace calico-cloud -o jsonpath --template '{.status}'
```
Make sure that state is **done**

Installation process will take around 5 minutes

Configure log flush intervals in the cluster, we will use 10s instead of default value 300s for lab testing only.

```
kubectl patch felixconfiguration.p default -p '{"spec":{"flowLogsFlushInterval":"10s"}}'
kubectl patch felixconfiguration.p default -p '{"spec":{"dnsLogsFlushInterval":"10s"}}'
kubectl patch felixconfiguration.p default -p '{"spec":{"flowLogsFileAggregationKindForAllowed":1}}'
```

🏁 Finish
=========

To complete this challenge, press **NEXT**.
