FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/BreakdownsHub/megarest-python"
LABEL org.opencontainers.image.description="MegaRest Docker"

ARG TARGETPLATFORM BUILDPLATFORM
ENV TZ Asia/Jakarta
WORKDIR /usr/src/app
SHELL ["/bin/bash", "-c"]
RUN chmod 777 /usr/src/app

RUN apt-get -y update && DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y python3 python3-pip aria2 qbittorrent-nox \
    tzdata p7zip-full p7zip-rar xz-utils curl wget pv jq ffmpeg git \
    locales git unzip rtmpdump libmagic-dev libcurl4-openssl-dev \
    libssl-dev libc-ares-dev libsodium-dev libcrypto++-dev \
    libsqlite3-dev libfreeimage-dev libpq-dev libffi-dev neofetch mediainfo \
    binutils && strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 \
    && locale-gen en_US.UTF-8 && \
    curl -L https://github.com/lzzy12/megasdkrest/releases/download/v0.1.14-rebuild/megasdkrest-$(cpu=$(uname -m);\
    if [[ "$cpu" == "x86_64" ]]; then echo "amd64"; elif [[ "$cpu" == "x86" ]]; \
    then echo "i386"; elif [[ "$cpu" == "aarch64" ]]; then echo "arm64"; else echo $cpu; fi) \
    -o /usr/local/bin/megasdkrest && chmod +x /usr/local/bin/megasdkrest

RUN wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht.dat -O /usr/src/app/dht.dat \
    && wget -q https://github.com/P3TERX/aria2.conf/raw/master/dht6.dat -O /usr/src/app/dht6.dat

RUN apt-get -y update && apt-get -y upgrade && apt-get -y autoremove && apt-get -y autoclean

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en"
