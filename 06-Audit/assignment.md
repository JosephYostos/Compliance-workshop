---
slug: audit
id: 74dfcvbjg7zi
type: challenge
title: Get compliance reports
teaser: Leverage pre-built reports for audit and reporting purposes
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
timelimit: 900
---

Audit Logs
===============

Calico Cloud audit logs provide security, platform and DevOps teams and auditors historical data of all changes to the resources over time.

Calico audit logs are enabled by default for the following resources:

- Global networkpolicies
- Network policies
- Staged global networkpolicies
- Staged networkpolicies
- Staged Kubernetes network policies
- Global network sets
- Network sets
- Tiers
- Host endpoints

Audit Timeline
===============

Policy Audit logs are accessible through the Calico Cloud directly through the Timeline feature. To view these logs:

1. Open the `Timeline` page from the left navigation menu.

![Image Description](../assets/menu.png)

2. Either browse through the list of Audit Events or search using the filter at the top of the page.

- Policy Audit Timeline
![Image Description](../assets/timeline.png)

- Policy Audit Filter
![Image Description](../assets/timeline-filter.png)

3. Policy Audit Events contain the policy effected, the user to make the change and the manifest of the updated policy.
![Image Description](../assets/policy-audit.png)

Policy Audit Inside of Policy
===============

Within each Policy, there is a Change Log that allows you to see the audit entries for the specific policy you are currently viewing.

To access this information,

1. Open a Policy from from the Policies page and scroll down to the Change Log section.
![Image Description](../assets/policy-history.png)

2. Click on the diff button on an Audit Event to expand the details of that event.
![Image Description](../assets/policy-history-2.png)

3. To view the change in detail, click the 'split view' checkbox in the top right to bring up a side by side comparison of the two versions.
![Image Description](../assets/policy-diff.png)

Archive logs
===============

Logs can be exported to an external SIEM such as Splunk, syslog, or Amazon S3. For further information see archive logs section in [calico documentaion.](https://docs.tigera.io/v3.14/visibility/elastic/archive-storage)

Compliance reports
===============

Using the reporting feature of Calico Cloud you can create a number of reports to satisfy the various PCI DSS and SOC 2 reporting requirements.
Calico Cloud supports the following built-in report types:

- Inventory
- Network Access
- Policy-Audit
- CIS Benchmark

We have already scheduled some reports to run daily .

Check the `GlobalReports` in your environment

```bash
kubectl get globalreports
```

For the purpose of the workshop, we will run these reports manually using the following script:

```bash
./run-reports.sh
```

To view the generated reports in Calico Cloud click on `Compliance` from the left menu. You also export the reports.


![Image Description](../assets/reports.png)

🏁 Finish
=========

Press **Next** to continue to the next challenge.
