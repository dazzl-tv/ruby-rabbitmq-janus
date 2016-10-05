# RabbitMQ server info

The configuration file contains two parts.

The RabbitMQ server information for connection, and the queue used by janus.

By default the configuration file look like this :

```yaml
server:
    host: 'localhost'
    port: 5672
    vhost: '/'
    user: 'guest'
    password: 'guest'

queues:
    queue_from: from-janus
    queue_to: to-janus

janus:
  plugins:
    - janus.plugin.echotest

gem:
  log:
    level: WARN
  session:
    keepalive: 45
  thread:
    enable: false
    number: 1
```

## Customize
For customizing a configuration add a yml file in your rails project in
`config/ruby-rabbitmq-janus.yml`.

## Ressources
* [Configuration of RabbitMQ](https://www.rabbitmq.com/configure.html#config-items)
* [Configuration of Janus queue](https://janus.conf.meetecho.com/docs/rest.html#rabbit)
