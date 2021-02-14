ARG TOOLCHAIN_VERSION=gcc8_4_0-esp-2020r3-linux-amd64
ARG SDK_VERSION=v3.4-rc

FROM ubuntu:16.04
ARG TOOLCHAIN_VERSION
ARG SDK_VERSION
ADD https://dl.espressif.com/dl/xtensa-lx106-elf-${TOOLCHAIN_VERSION}.tar.gz /xtensa-lx106.tar.gz
ADD https://github.com/espressif/ESP8266_RTOS_SDK/releases/download/${SDK_VERSION}/ESP8266_RTOS_SDK-${SDK_VERSION}.zip /ESP8266_RTOS_SDK.zip
RUN apt-get update \
    && apt-get install -y \
        tar \
        unzip \
        git \
        gcc \
        wget \
        make \
        libncurses-dev \
        flex \
        bison \
        gperf \
        python \
        python-serial\
        python-pip \
    && mkdir -p /opt/toolchains \
    && tar -xzf /xtensa-lx106.tar.gz -C /opt/toolchains \
    && mv /opt/toolchains/xtensa-lx106-elf /opt/toolchains/lx106 \
    && unzip /ESP8266_RTOS_SDK.zip -d /opt \
    && mv /opt/ESP8266_RTOS_SDK /opt/sdk \
    && rm /xtensa-lx106.tar.gz /ESP8266_RTOS_SDK.zip \
    && python -m pip install --user "cryptography==3.3.2" \
    && python -m pip install --user -r /opt/sdk/requirements.txt


ENV PATH=/opt/toolchains/lx106/bin:$PATH
ENV IDF_PATH=/opt/sdk
