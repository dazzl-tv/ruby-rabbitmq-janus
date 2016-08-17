# ruby-rabbitmq-janus
Ruby Gem for Dazzl Backend/Janus integration using RabbitMQ message queue

This gem is used to communicate to a server Janus through RabbitMQ software (Message-
oriented middleware). It waiting a messages to Rails API who send to RabbitMQ server in a
queue for janus server. janus processes a message and send to RabbitMQ server in a queue
for gem. Once the received message is decoded and returned through the Rails API.

# How to use

### Installation

Use github for installing gem in your Gemfile
```ruby
gem 'rrj', :git => 'git@github.com:dazzl-tv/ruby-rabbitmq-janus.git'
```

# Documentation

This doc is generated with yard.

```
# Launch server
yard server
```
