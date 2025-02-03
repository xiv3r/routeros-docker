FROM --platform=$BUILDPLATFORM alpine AS build

LABEL maintainer="Henrique Sebastião <contato@henriquesebastiao.com>"

ENV ROUTEROS_URL=https://download.mikrotik.com/routeros/7.17.1/chr-7.17.1.vdi.zip
ENV ROUTEROS_IMAGE=chr-7.17.1.vdi
ENV ROUTEROS_VERSION=7.17.1
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

EXPOSE 1723 1701 1194 21 22 23 443 80 8291 8728 8729

RUN chmod +x /routeros/bin/entrypoint.sh && \
    chmod +x /routeros/bin/generate-dhcpd-conf.py && \
    chmod +x /routeros/bin/qemu-ifup && \
    chmod +x /routeros/bin/qemu-ifdown

ENTRYPOINT ["/routeros/bin/entrypoint.sh"]