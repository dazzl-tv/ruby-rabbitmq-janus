FROM quay.io/dazzl/janus-gateway:rrj-spec

COPY janus.1.jcfg /usr/local/etc/janus/janus.jcfg
COPY janus.1.transport.rabbitmq.jcfg /usr/local/etc/janus/janus.transport.rabbitmq.jcfg
