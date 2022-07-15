---
slug: connect-cluster
id: x4njq6m0sqwh
type: challenge
title: Connect Kubernetes cluster to Calico Cloud
teaser: Connect your cluster in few minutes.
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
Signup and log into your Calico Cloud account.
Note: Use same email address from instruqt signup for Calicocloud signup
===============

Use the Calico Cloud tab to get your environment :

<img src="https://github.com/JosephYostos/kubeadm-installation/blob/main/login.png?raw=true" alt="login" width="100%"/>

Once you activated your Calico Cloud account with your email, login to Calico Cloud using the same tab

Connecting your demo application with Calico Cloud
===============
Click the "Managed Cluster" in your left side of browser, then click on "connect cluster"

![Image Description](../assets/connect-cluster.png)

Enter your cluster name, choose kubeadm and click next

![Image Description](../assets/choose-kubeadm.png)

Copy the installation script and use the terminal tab in Instruqt to run it in your cluster

![Image Description](../assets/script.png)

 Validate what we have done
==============

**Installation process will take around 5 minutes**

Use the terminal to check the Calico Cloud installation status:

```
kubectl get installer default --namespace calico-cloud -o jsonpath --template '{.status}{"\n"}'
```

once installtion is complete the status will change from **installing** to **done**

Check the installation status from the `managed clusters` page in Calico Cloud

![Image Description](../assets/Monitor-installation.png) 


Make sure that state is **done** before you move to the next challange

 Configure log flush intervals
==============
Configure log flush intervals in the cluster, we will use 10s instead of default value 300s for lab testing only.

```
kubectl patch felixconfiguration.p default -p '{"spec":{"flowLogsFlushInterval":"10s"}}'
kubectl patch felixconfiguration.p default -p '{"spec":{"dnsLogsFlushInterval":"10s"}}'
kubectl patch felixconfiguration.p default -p '{"spec":{"flowLogsFileAggregationKindForAllowed":1}}'
```

🏁 Finish
=========

To complete this challenge, press **NEXT**.
