FROM gitpod/workspace-full-vnc
USER root

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list && \
    apt-get update && \
    apt-get -y install build-essential libkrb5-dev gcc make dart && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/gitpod
USER gitpod

ENV PATH="/home/gitpod/flutter/bin:$PATH"

RUN git clone https://github.com/flutter/flutter -b stable --depth=1 && \
    flutter upgrade && \
    flutter --version && \
    flutter config --enable-web

ENV PUB_CACHE=/workspace/.pub_cache
