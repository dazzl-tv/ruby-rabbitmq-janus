# ruby-rabbitmq-janus
Ruby Gem for Dazzl Backend/Janus integration using RabbitMQ message queue.

This gem is used to communicate to a server Janus through RabbitMQ software (Message-
oriented middleware). It waiting a messages to Rails API who send to RabbitMQ server in a
queue for janus server. janus processes a message and send to RabbitMQ server in a queue
for gem. Once the received message is decoded and returned through the Rails API.

## Menu
* [How to use](#how-to-use)
 * [Installation](#installation)
 * [Usage](#usage)
* [RSpec](#rspec-test)
* [Documentation](#documentation)

## How to use

### Installation

Use github for installing gem in your Gemfile
```ruby
gem 'rrj', :git => 'git@github.com:dazzl-tv/ruby-rabbitmq-janus.git'
```

### Usage

TODO 

## RSpec test

```linux
bundle exec rspec
```

## Documentation

This doc is generated with yard.

```
# Genereate doc
yard
# Launch server
yard server
```

see [Yard Getting Started](http://www.rubydoc.info/gems/yard/file/docs/GettingStarted.md)
