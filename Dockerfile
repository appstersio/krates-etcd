FROM quay.io/coreos/etcd:v2.3.8
LABEL maintainer="Pavel Tsurbeleu <pavel.tsurbeleu@me.com>"

VOLUME [ "/data" ]

ENTRYPOINT [ "/usr/local/bin/etcd" ]