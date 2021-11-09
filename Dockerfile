FROM ubuntu:21.10

RUN set -ex \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq -y dist-upgrade \
    && apt-get -qq -y install --no-install-recommends \
        locales python3 python3-lxml python3-pip \
        libc-ares-dev libcrypto++-dev libcurl4-openssl-dev \
        libmagic-dev libsodium-dev libsqlite3-dev libssl-dev \
        aria2 curl wget ffmpeg jq git p7zip-full p7zip-rar pv mediainfo neofetch \
    && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
    && locale-gen \
    && curl -fsSL https://github.com/jaskaranSM/megasdkrest/releases/download/v0.1/megasdkrest -o /usr/local/bin/megasdkrest \
    && chmod +x /usr/local/bin/megasdkrest \
    && apt-get -qq -y autoremove --purge \
    && apt-get -qq -y clean \
    && rm -rf -- /var/lib/apt/lists/* /var/cache/apt/archives/* /etc/apt/sources.list.d/*

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8
