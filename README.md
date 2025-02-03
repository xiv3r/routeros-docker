# Mikrotik RouterOS on Docker

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
            - "21:21" # ftp
            - "22:22" # ssh
            - "23:23" # telnet
            - "80:80" # www
            - "443:443" # www-ssl
            - "1194:1194" # OVPN
            - "1450:1450" # L2TP
            - "8291:8291" # winbox
            - "8728:8728" # api
            - "8729:8729" # api-ssl
            - "13231:13231" # WireGuard
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
    -p 21:21 \
    -p 22:22 \
    -p 23:23 \
    -p 80:80 \
    -p 443:443 \
    -p 1194:1194 \
    -p 1450:1450 \
    -p 8291:8291 \
    -p 8728:8728 \
    -p 8729:8729 \
    -p 13231:13231 \
    --cap-add=NET_ADMIN \
    --device=/dev/net/tun \
    henriquesebastiao/routeros:latest
```

### Parameters

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 21:21` | FTP |
| `-p 22:22` | SSH |
| `-p 23:23` | Telnet |
| `-p 80:80` | WWW |
| `-p 443:443` | WWW-SSL |
| `-p 1194:1194` | OVPN |
| `-p 1450:1450` | L2TP |
| `-p 8291:8291` | Winbox |
| `-p 8728:8728` | API |
| `-p 8729:8729` | API-SSL |
| `-p 13231:13231` | WireGuard |
| `--cap-add=NET_ADMIN` | Add capabilities to the container |
| `--device=/dev/net/tun` | Add a device to the container |
