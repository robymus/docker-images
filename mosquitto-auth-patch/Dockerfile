FROM debian:9.4
MAINTAINER Robert Elek <r@r2.io>

LABEL Description="Compilied Eclipse Mosquitto with patched auth-plug"

RUN adduser --system mosquitto

RUN apt update && \
    apt -y install gcc g++ make git wget libssl-dev libcurl4-openssl-dev libc-ares-dev uuid-dev libwebsockets-dev

RUN cd /root && \
    wget https://github.com/eclipse/mosquitto/archive/v1.4.15.tar.gz && \
    tar xvfz v1.4.15.tar.gz && \
    git clone --depth 1 https://github.com/robymus/mosquitto-auth-plug.git mosquitto-auth-plug

COPY mosquitto-auth-plug-config.mk /root/mosquitto-auth-plug/config.mk

RUN cd /root/mosquitto-1.4.15 && \
    make WITH_WEBSOCKETS=yes WITH_DOCS=no && \
    make install WITH_WEBSOCKETS=yes WITH_DOCS=no

COPY mosquitto-auth-plug-config.mk /root/mosquitto-auth-plug/config.mk

RUN cd /root/mosquitto-auth-plug && \
    make && \
    mkdir -p /usr/local/lib/mosquitto && \
    cp auth-plug.so /

COPY mosquitto.conf /etc/mosquitto/

CMD ["/usr/local/sbin/mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"]
