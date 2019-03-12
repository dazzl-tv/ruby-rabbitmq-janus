FROM quay.io/dazzl/janus-gateway:rrj-spec

COPY janus.1.cfg /usr/local/etc/janus/janus.cfg
COPY janus.1.transport.rabbitmq.cfg /usr/local/etc/janus/janus.transport.rabbitmq.cfg

ENTRYPOINT ["/usr/local/bin/janus"]
CMD ["-d5"]
