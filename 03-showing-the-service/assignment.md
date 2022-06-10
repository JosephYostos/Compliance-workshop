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
- title: NodePort
  type: service
  hostname: controlplane
  path: /
  port: 30001
difficulty: basic
timelimit: 600
---

💡 The NGINX tab
================

This is an embedded nginx tab of the NodePort service you deployed in the previous challenge.

Press **Check** to continue to the next challenge.
