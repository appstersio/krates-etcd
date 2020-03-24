FROM busybox
LABEL maintainer="Pavel Tsurbeleu <pavel.tsurbeleu@me.com>"

ENV ETCD_RELEASE=2.3.7
ADD https://github.com/coreos/etcd/releases/download/v${ETCD_RELEASE}/etcd-v${ETCD_RELEASE}-linux-amd64.tar.gz \
    etcd-v${ETCD_RELEASE}-linux-amd64.tar.gz
RUN tar xzvf etcd-v${ETCD_RELEASE}-linux-amd64.tar.gz && \
    mv etcd-v${ETCD_RELEASE}-linux-amd64/etcd /bin && \
    mv etcd-v${ETCD_RELEASE}-linux-amd64/etcdctl /bin && \
    rm etcd-v${ETCD_RELEASE}-linux-amd64.tar.gz && \
    rm -Rf etcd-v${ETCD_RELEASE}-linux-amd64*

EXPOSE 2379 2380

VOLUME [ "/data" ]

ENTRYPOINT [ "/bin/etcd" ]