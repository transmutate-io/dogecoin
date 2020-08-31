FROM debian:10.3-slim

ENV VERSION 1.14.2

ENV DATA "/data"

COPY entrypoint.sh /

RUN mkdir -p /opt && \
    cd /opt && \
    apt-get update -y && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget -O - https://github.com/dogecoin/dogecoin/releases/download/v${VERSION}/dogecoin-${VERSION}-x86_64-linux-gnu.tar.gz | tar xvz && \
    echo /opt/dogecoin-${VERSION}/lib > /etc/ld.so.conf.d/dogecoin.conf && \
    ldconfig && \
    mkdir -p "${DATA}" && \
    chmod 700 "${DATA}" && \
    chmod 555 /entrypoint.sh

ENV PATH /opt/dogecoin-${VERSION}/bin:$PATH

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["dogecoind"]