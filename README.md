[![Build Status](https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus.svg?branch=master)](https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus)
[![Gem Version](https://badge.fury.io/rb/ruby_rabbitmq_janus.svg)](https://badge.fury.io/rb/ruby_rabbitmq_janus)
[![inline docs](http://inch-ci.org/github/dazzl-tv/ruby-rabbitmq-janus.svg)](http://inch-ci.org/github/dazzl-tv/ruby-rabbitmq-janus)

# ruby-rabbitmq-janus -- RRJ

Ruby Gem for Janus WebRTC Gateway integration using RabbitMQ message queue

This gem is used to communicate to a server Janus through RabbitMQ software (
Message-oriented middleware). It waiting a messages to Rails API who send to RabbitMQ
server in a queue for janus server. janus processes a message and send to RabbitMQ server
in a queue for gem. Once the received message is decoded and returned through the Rails API.


This gem is product by [Dazzl.tv](http://dazzl.tv)

## Menu
* [How to use](#how-to-use)
 * [Installation](#installation)
 * [Configuration](#configuration)
    * [Generators](#generators)
    * [Requests](#requests)
 * [Usage](#usage)
* [Upgrade](#upgrade)
* [Development](#development)
 * [RSpec](#rspec-test)
 * [Documentation](#documentation)
    * [Read documentation](#read-documentation)
    * [Generate developer documentation](#generate-developer-documentation)

## How to use

### Installation

Use rubygem for installing gem in your application. Add in your Gemfile
```ruby
gem 'ruby_rabbitmq_janus'
```

### Configuration

If you want used a customize configuration see [ruby-rabbitmq-janus.yml](config/default.md)

#### Generators

Use generator for complete installation :

```ruby
rails g -h
RubyRabbitmqJanus:
  ruby_rabbitmq_janus:configuration
  # Generate a custom configuration file.

  ruby_rabbitmq_janus:default_request
  # Copy base request file sending to janus in application. It's necessary if you want add your request.

  ruby_rabbitmq_janus:initializer
  # Generate a initializer to this gem for rails application.

  ruby_rabbitmq_janus:create_request
  # Create an request to json format for RubyRabbitmqJanus transaction.
```

#### Requests

For create an new request is simple. Use a command generator :

```ruby
rails g ruby_rabbitmq_janus:create_request test info 'transaction:<string>,body:{plugins:false}'
      create  config/requests/test/info.json
```

For more explain in requests files see [default requests](config/requests.md).

### Usage


TODO ...

## Development

### RSpec test

```linux
bundle exec rspec
```

TIPS: for rspec install janus and rabbitmq server configured by default for user
rabbitmq and use plugin echotest for janus server.

Use tags for rspec :

| Describe                                                      | Type            | Name            |
| ------------------------------------------------------------- | --------------- | --------------- |
| Request JSON sending to Rabbitmq -> Janus                     | request         | attach          |
|                                                               |                 | create          |
|                                                               |                 | detach          |
|                                                               |                 | info            |
|                                                               |                 | test            |
| Level request sending to janus (admin monitor API or classic) | level           | base            |
|                                                               |                 | admin           |
| Internaly function                                            | config          | rabbit          |
|                                                               |                 | log             |
|                                                               |                 | config          |

## Upgrade

For upgrade your application read [CHANGELOG.md](CHANGELOG.md)

### Documentation

#### Read documentation

The documentation is accessible in [rubydoc](http://www.rubydoc.info/gems/ruby_rabbitmq_janus/)

#### Generate developer documentation

This doc is generated with yard.

```
# Genereate doc
yard
# Launch server
yard server
```

[See Yard Getting Started](http://www.rubydoc.info/gems/yard/file/docs/GettingStarted.md)
