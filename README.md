# homeserver

**work in progress!!**

This repository contains the (very simple) declarative configuration for my home server. The software stack is based on [NixOS](https://nixos.org/),
a Linux distribution that is configured declaratively using several configuration files.

The entire infrastructure uses containers and it is a single `docker-compose` file.

## Architecture

![Diagram](https://github.com/user-attachments/assets/3e03119c-e651-41d3-ae21-92e6a10c9cc5)

I try to keep the setup as simple as possible, to avoid headache (and beacuse i don't want to spend a lot of time mantaning it).
All my services run as **Docker containers** in bridge mode, using Docker Compose.

All ports exposed by services are also exposed on the firewall config in NixOS, and they are always accessible inside the local network.

## Remote access

I do not have a public IP address and i'm also behind a very shitty double-NAT.

In order to access my services and home network from outside, i use [Tailscale VPN](https://tailscale.com/). This way, i don't have to worry about NAT and such because Tailscale
does automatic NAT-traversal and, if the client is connected to the VPN, i can access my home network from everywhere.

Yes, i know it is possible to setup WireGuard to NAT-traverse using an online VPS, but i wanted to avoid having to also mantain that.

## Services

Running on Docker containers:

- [Homarr](https://dashy.to/): Server dashboard
- [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome): Network level ad blocking DNS
- [PhotoPrism](https://www.photoprism.app/): Self-hosted photo archive solution
  - note: i will probably switch to [Immich](https://immich.app/) when it is more stable.
- [Backrest](https://github.com/garethgeorge/backrest): Automatic data backup
- [Prometheus](https://prometheus.io/): Metrics, alerts gathering
- [Grafana](https://grafana.com/): Data visualization

Running on the host:

- [Tailscale client](https://tailscale.com): VPN to access the network from remote
- [Cockpit](https://cockpit-project.org/): Web-based system administration tool
