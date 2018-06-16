#
# Mosquitto with patched auth-plug to support IP based authentication
#


#
# Multistage build
#
FROM debian:9.4 AS build
# default tag to pull from https://github.com/robymus/mosquitto-auth-plug.git
ENV AUTH_PLUG_TAG=orig-20180616

WORKDIR /root

# prepare tools and base source
RUN apt update && \
    apt upgrade -y && \
    apt -y install gcc g++ make git wget libssl-dev libcurl4-openssl-dev libc-ares-dev uuid-dev libwebsockets-dev && \
    wget https://github.com/eclipse/mosquitto/archive/v1.4.15.tar.gz && \
    tar xfz v1.4.15.tar.gz 

# build mosquitto
WORKDIR /root/mosquitto-1.4.15
RUN make WITH_WEBSOCKETS=yes WITH_DOCS=no DESTDIR=/opt/mosquitto && \
    make install WITH_WEBSOCKETS=yes WITH_DOCS=no DESTDIR=/opt/mosquitto && \
    rm -rf /opt/mosquitto/etc/*
COPY mosquitto.conf /opt/mosquitto/etc/

# build auth plug
WORKDIR /root
RUN git clone --depth 1 --branch $AUTH_PLUG_TAG https://github.com/robymus/mosquitto-auth-plug.git mosquitto-auth-plug
WORKDIR /root/mosquitto-auth-plug
COPY mosquitto-auth-plug-config.mk config.mk
RUN make && \
    cp auth-plug.so /opt/mosquitto/

#
# Create final image
#
FROM debian:9.4-slim
RUN adduser --system mosquitto
LABEL Maintainer="Robert Elek <r@r2.io>"
LABEL Description="Compiled Eclipse Mosquitto with patched auth-plug"
# add binary dependencies
RUN apt update && \
    apt upgrade -y && \
    apt -y install libssl1.1 libwebsockets8 libcurl3
# copy from build
COPY --from=build /opt/mosquitto /opt/mosquitto
# startup
CMD ["/opt/mosquitto/usr/local/sbin/mosquitto", "-c", "/opt/mosquitto/etc/mosquitto.conf"]

EXPOSE 1883
VOLUME /opt/mosquitto/etc

