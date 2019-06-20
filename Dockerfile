FROM quay.io/coreos/etcd:v3.3.13
LABEL maintainer="Pavel Tsurbeleu <pavel.tsurbeleu@me.com>"

RUN apk --update add ca-certificates openssl

VOLUME [ "/data" ]

ENTRYPOINT [ "/usr/local/bin/etcd" ]