# RabbitMQ server info

The configuration file contains many parts.

By default the configuration file look like this :

```yaml
rabbit:
    host: 'localhost'
    port: 5672
    vhost: '/'
    user: 'guest'
    password: 'guest'
    admin_pass: janusoverlord

queues:
    queue_from: from-janus
    queue_to: to-janus
    admin:
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
`config/ruby-rabbitmq-janus.yml`, or use rails generator with command `rails generate
ruby_rabbitmq_janus:configuration`.

## Ressources
* [Configuration of RabbitMQ](https://www.rabbitmq.com/configure.html#config-items)
* [Configuration of Janus queue](https://janus.conf.meetecho.com/docs/rest.html#rabbit)
