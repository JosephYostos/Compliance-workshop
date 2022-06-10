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
