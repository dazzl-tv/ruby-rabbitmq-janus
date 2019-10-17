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
    level: :info

queues:
  standard:
    from: from-janus
    to: to-janus
  admin:
    from: from-janus-admin
    to: to-janus-admin
  instance: janus-instance-thread

janus:
  session:
    keepalive: 45
  plugins:
    - janus.plugin.echotest

gem:
  cluster:
    enabled: true
  log:
    level: info
    type: file
    option: ''
  listener:
    public: 'app/ruby_rabbitmq_janus/action_events'
    admin: 'app/ruby_rabbitmq_janus/action_admin_events'
  environment: 'development'
  orm: 'mongoid'
  response_path: 'spec/supports/rrj/responses'
```

## Customize

For customizing a configuration add a yml file in your rails project in
`config/ruby-rabbitmq-janus.yml`, or use rails generator with command `rails generate
ruby_rabbitmq_janus:configuration`.

## Resources

* [Configuration of RabbitMQ](https://www.rabbitmq.com/configure.html#config-items)
* [Configuration of Janus queue](https://janus.conf.meetecho.com/docs/rest.html#rabbit)
