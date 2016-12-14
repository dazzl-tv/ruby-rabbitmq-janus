# RabbitMQ server info

The configuration file contains many parts.

By default the configuration file look like this :

```yaml
rabbit:
    host: localhost
    port: 5672
    vhost: /
    user: guest
    pass: guest
    admin_pass: janusoverlord

queues:
  standard:
    from: from-janus
    to: to-janus
    admin:
      from: from-janus-admin
      to: to-janus-admin

janus:
  session:
    keepalive: 45
  plugins:
    - janus.plugin.echotest

gem:
  log:
    level: info
```

## Customize

For customizing a configuration add a yml file in your rails project in
`config/ruby-rabbitmq-janus.yml`, or use rails generator with command `rails generate
ruby_rabbitmq_janus:configuration`.

## Ressources

* [Configuration of RabbitMQ](https://www.rabbitmq.com/configure.html#config-items)
* [Configuration of Janus queue](https://janus.conf.meetecho.com/docs/rest.html#rabbit)
