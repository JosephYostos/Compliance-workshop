---
slug: security-policies
id: hq5xvisin8sa
type: challenge
title: create Policies
teaser: Apply Security Policies to restrict access 
notes:
- type: text
  contents: |-
   Now that we've deployed our web store application, in order to comply with the PCI DSS standard we have to secure it. This means applying Security Policies to restrict access as a much as possible. In this section we will walk through building up a robust security policy for our application.
- type: text
  contents: |-
## Policy Introduction

Kubernetes and Calico Security Policies are made up of three main components that all need to be properly designed and implemented to achieve compliance.

**Labels** - Tag Kubernetes objects for filtering.

**Security Policy** - The primary tool for securing a Kubernetes network. It lets you restrict network traffic in your cluster so only the traffic that you want to flow is allowed. Calico Cloud provides a more robust policy than Kubernetes, but you can use them together – seamlessly.

**Policy Tiers** - A hierarchical construct used to group policies and enforce higher precedence policies that cannot be circumvented by other teams.

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
timelimit: 600
---

💡 Label Examples
================

First, lets manually apply a label to the multitool pod. 

```bash
kubectl label pod multitool mylabel=true
```

We can then see the resulting label using:

```bash
kubectl get pod multitool --show-labels

NAME        READY   STATUS    RESTARTS   AGE    LABELS
multitool   1/1     Running   0          2d6h   mylabel=true,run=multitool
```

Now lets use this to attach a PCI label to our application pods. Rather than apply the label one by one, label all pods in the hipstershop namespace with 'pci=true' with the following command:

```bash
kubectl label pods --all -n hipstershop pci=true
```

Then, verify the labels are applied:

```bash
kubectl get pods -n hipstershop --show-labels
```
```bash
tigera@bastion:~$ kubectl get pods -n hipstershop --show-labels
NAME                                     READY   STATUS    RESTARTS   AGE   LABELS
adservice-6569cd7bb6-v9v54               1/1     Running   0          28h   app=adservice,pci=true,pod-template-hash=6569cd7bb6
cartservice-f45c6bd9b-4h4pn              1/1     Running   22         28h   app=cartservice,pci=true,pod-template-hash=f45c6bd9b
checkoutservice-8596f74dc8-cj9vf         1/1     Running   0          28h   app=checkoutservice,pci=true,pod-template-hash=8596f74dc8
currencyservice-85599889d4-kspv5         1/1     Running   0          28h   app=currencyservice,pci=true,pod-template-hash=85599889d4
emailservice-78778f689b-dfljq            1/1     Running   0          28h   app=emailservice,pci=true,pod-template-hash=78778f689b
frontend-7cb647d79c-kz2gq                1/1     Running   0          28h   app=frontend,pci=true,pod-template-hash=7cb647d79c
loadgenerator-6cdf76b6d4-vscmj           1/1     Running   0          28h   app=loadgenerator,pci=true,pod-template-hash=6cdf76b6d4
multitool                                1/1     Running   0          28h   pci=true,run=multitool
paymentservice-868bc5ffcd-4k5sx          1/1     Running   0          28h   app=paymentservice,pci=true,pod-template-hash=868bc5ffcd
productcatalogservice-6948774f48-5xznt   1/1     Running   0          28h   app=productcatalogservice,pci=true,pod-template-hash=6948774f48
recommendationservice-cd689fc7d-h6w59    1/1     Running   0          28h   app=recommendationservice,pci=true,pod-template-hash=cd689fc7d
redis-cart-74594bd569-vg25j              1/1     Running   0          28h   app=redis-cart,pci=true,pod-template-hash=74594bd569
shippingservice-85c8d66568-jrdsf         1/1     Running   0          28h   app=shippingservice,pci=true,pod-template-hash=85c8d66568
```

Now that the pods are labelled, lets start applying some policy to them.

💡 Policy Tiers
================

For this workshop, we'll be creating 3 tiers in the cluster and utilizing the default tier as well:

**security** - Global security tier with controls such as PCI restrictions.

**platform** - Platform level controls such as DNS policy and tenant level isolation.

**app-hipster** - Application specific tier for microsegmentation inside the application.

To create the tiers apply the following manifest:

```yaml
kubectl apply -f -<<EOF
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: app-hipstershop
spec:
  order: 400
---
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: platform
spec:
  order: 300
---   
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: security
spec:
  order: 200
EOF
```

💡  General Policies
================

After creating our tiers, we'll apply some general policies to them before we start creating our main policies. These policies include allowing traffic to kube-dns from all pods, passing traffic that doesn't explicitly match in the tier and finally a default deny policy.




Press **Check** to continue to the next challenge.
