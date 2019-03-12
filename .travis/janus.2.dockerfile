FROM quay.io/dazzl/janus-gateway:rrj-spec

COPY janus.2.cfg /usr/local/etc/janus/janus.cfg
COPY janus.2.transport.rabbitmq.cfg /usr/local/etc/janus/janus.transport.rabbitmq.cfg

ENTRYPOINT ["/usr/local/bin/janus"]
CMD ["-d5"]
