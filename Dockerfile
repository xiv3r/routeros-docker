FROM --platform=$BUILDPLATFORM alpine AS build

LABEL maintainer="Henrique Sebastião <contato@henriquesebastiao.com>"

ARG ROUTEROS_VERSION

ENV ROUTEROS_URL=https://download.mikrotik.com/routeros/${ROUTEROS_VERSION}/chr-${ROUTEROS_VERSION}.vdi.zip
ENV ROUTEROS_IMAGE=chr-${ROUTEROS_VERSION}.vdi
ENV ROUTEROS_VERSION=${ROUTEROS_VERSION}
ENV VNCPASSWORD=false
ENV KEYBOARD=en-us

RUN set -xe && \
    apk add --no-cache --update \
        wget \
        netcat-openbsd \
        qemu-x86_64 \
        qemu-system-x86_64 \
        busybox-extras \
        iproute2 \
        iputils \
        bridge-utils \
        iptables \
        jq \
        bash \
        python3 \
        curl && \
    mkdir /routeros && wget ${ROUTEROS_URL} -O /routeros/${ROUTEROS_IMAGE}.zip && \
    unzip /routeros/${ROUTEROS_IMAGE}.zip -d /routeros && \
    rm -fr /routeros/${ROUTEROS_IMAGE}.zip

WORKDIR /routeros

COPY bin /routeros/bin

EXPOSE 20/tcp 21/tcp 22/tcp 23/tcp 53/tcp 53/udp 67/udp 68/udp 80/tcp 123/udp 161/udp 443/tcp 500/udp 546/udp 547/udp 1194/tcp 1194/udp 1701/udp 1723/tcp 2000/tcp 2000/udp 4500/udp 5678/udp 8080/tcp 8291/tcp 8728/tcp 8729/tcp 13231/udp

RUN chmod +x /routeros/bin/entrypoint.sh && \
    chmod +x /routeros/bin/generate-dhcpd-conf.py && \
    chmod +x /routeros/bin/qemu-ifup && \
    chmod +x /routeros/bin/qemu-ifdown

ENTRYPOINT ["/routeros/bin/entrypoint.sh"]