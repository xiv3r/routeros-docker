# Mikrotik RouterOS on Docker

![Mikrotik](https://img.shields.io/badge/Mikrorik-293239?style=flat&logo=mikrotik&logoColor=white)
[![LICENSE](https://img.shields.io/github/license/henriquesebastiao/routeros-docker)](LICENSE)
[![Version](https://img.shields.io/github/v/release/henriquesebastiao/routeros-docker)](Version)

Docker image for Mikrotik RouterOS.

![winbox](https://github.com/user-attachments/assets/dcb7056c-6056-45a5-8c6b-726e8056a6ea)

> [!IMPORTANT]
> This docker image was made for testing and lab use only. I am not responsible if you use it for commercial or production purposes.

## Supported Architectures

Simply pulling `henriquesebastiao/routeros:latest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available |
| :----: | :----: |
| x86-64 | ✅ |
| arm64 | ✅ |

## Usage

To help you get started creating a container from this image you can either use docker-compose or the docker cli.

> [!NOTE]
> You can choose not to declare ports that you do not need.

### Docker Compose

```yaml
services:
    routeros:
        container_name: "routeros"
        image: henriquesebastiao/routeros:latest
        privileged: true
        ports:
            - "22:22" # SSH
            - "80:80" # Web
            - "8291:8291" # Winbox
        cap_add: 
            - NET_ADMIN
        devices: 
            - /dev/net/tun
```

### Docker CLI

```bash
docker run -d \
    --name=routeros \
    --privileged \
    -p 22:22 \
    -p 80:80 \
    -p 8291:8291 \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    henriquesebastiao/routeros:latest
```

### Ports and Protocols Exposed

Check the list of ports exposed in the image and use the ones necessary for your use case.

| Port | Protocol | Description |
| :----: | :----: | :---- |
| 20 | TCP | FTP Data |
| 21 | TCP | FTP Control |
| 22 | TCP | SSH |
| 23 | TCP | Telnet |
| 53 | TCP/UDP | DNS |
| 67 | UDP | DHCP Server |
| 68 | UDP | DHCP Client |
| 80 | TCP | HTTP |
| 123 | UDP | NTP |
| 161 | UDP | SNMP |
| 443 | TCP | HTTPS |
| 500 | UDP | Internet Key Exchange |
| 546 | UDP | DHCPv6 Client |
| 547 | UDP | DHCPv6 Server |
| 1194 | TCP/UDP | OpenVPN |
| 1701 | UDP | L2TP |
| 1723 | TCP | PPTP |
| 2000 | TCP/UDP | Bandwidth Test Server |
| 4500 | UDP | NAT Traversal |
| 5678 | TCP | Mikrotik Neighbor Discovery Protocol |
| 8080 | TCP | HTTP Proxy |
| 8291 | TCP | Winbox |
| 8728 | TCP | API |
| 8729 | TCP | API-SSL |
| 13231 | UDP | WireGuard |
