---
slug: encryption
id: okx4bnteerty
type: challenge
title: Encrypt the data-in-transit
teaser: Secure data-in-transit for your application with Wireguard
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

Encrypt data in transit
===============

Calico Cloud provideds WireGuard to secure on the wire in-cluster pod traffic.

When this capability is enabled, Calico Cloud will automatically create and manage WireGuard tunnels between nodes providing transport-level security for on-the-wire, in-cluster pod traffic for your demo application. WireGuard provides formally verified secure and performant tunnels without any specialized hardware.


Install WireGuard
===============

Before enabling end-to-end encryption with Calico, you must first install WireGuard. In this lab WireGuard is installed by deafult.
Instructions available here https://www.wireguard.com/install/ (you don't need to install it as it's already installed)

Test to ensure that the Wireguard module is loaded using the following command:

```bash
sudo lsmod | grep wireguard
```

The output should look something like this:

```bash
root@controlplane:~# sudo lsmod | grep wireguard
wireguard             221184  0
ip6_udp_tunnel         16384  2 wireguard,vxlan
udp_tunnel             16384  2 wireguard,vxlan
```

Enable End-to-End Encryption
===============

To enable end-to-end encryption, we will patch the 'felixconfiguration' with the 'wireguardEnabled' option.

```bash
kubectl patch felixconfiguration default --type='merge' -p '{"spec":{"wireguardEnabled":true}}'
```

To validate, you will need to check the node status for Wireguard entries with the following command:

```bash
kubectl get nodes -o yaml | grep 'kubernetes.io/hostname\|Wireguard'
```

Which will give you the following output showing the nodes hostname as well as the Wireguard Interface Address and PublicKey:

```bash
root@controlplane:~# kubectl get nodes -o yaml | grep 'kubernetes.io/hostname\|Wireguard'
      projectcalico.org/IPv4WireguardInterfaceAddr: 192.168.49.85
      projectcalico.org/WireguardPublicKey: cxDcVb0H8UvANa70Pt1JdShXHNuEDxiQRyIFlwRva3E=
      kubernetes.io/hostname: controlplane
      projectcalico.org/IPv4WireguardInterfaceAddr: 192.168.196.152
      projectcalico.org/WireguardPublicKey: x/vgnM2aIqsMmpAHvgfBUc8qchNgsaOTGHNV0z4C6kg=
      kubernetes.io/hostname: node01
```

On your node you can also view the new interface created by Wireguard with the ```wg``` command:

```bash
ubuntu@ip-10-0-1-30:~$ wg
interface: wireguard.cali
  public key: HmNsTyzg7TKvs/Fh0AmA0VEgtS+Ij6xBHqvzXO5VfmA=
  private key: (hidden)
  listening port: 51820
  fwmark: 0x200000

peer: gsxCZHLjKBjJozxRFiKjbMB3QtVTluQDmbvQVfANmXE=
  endpoint: 10.0.1.20:51820
  allowed ips: 10.48.115.64/26, 10.48.115.87/32, 10.0.1.20/32
  latest handshake: 1 minute, 26 seconds ago
  transfer: 22.09 MiB received, 12.46 MiB sent

peer: lDSws3G/G1KP76BGGRpVSXBnTt5N6FCqOodzTUUWs0I=
  endpoint: 10.0.1.31:51820
  allowed ips: 10.48.116.128/26, 10.48.116.146/32, 10.0.1.31/32
  latest handshake: 1 minute, 27 seconds ago
  transfer: 23.64 MiB received, 13.21 MiB sent
```

View WireGuard statistics
===============
To view WireGuard statistics in Calico Cloud's dashboard, you must enable them. From the left navigation bar, click Dashboard, and the Layout Settings icon.

![Image Description](../assets/WireGuard.png)


🏁 Finish
=========

Press **Next** to continue to the next challenge.
