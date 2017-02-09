[![Build Status](https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus.svg?branch=master)](https://travis-ci.org/dazzl-tv/ruby-rabbitmq-janus)
[![Gem Version](https://badge.fury.io/rb/ruby_rabbitmq_janus.svg)](https://badge.fury.io/rb/ruby_rabbitmq_janus)
[![inline docs](http://inch-ci.org/github/dazzl-tv/ruby-rabbitmq-janus.svg)](http://inch-ci.org/github/dazzl-tv/ruby-rabbitmq-janus)

# ruby-rabbitmq-janus -- RRJ

Ruby Gem for Janus WebRTC Gateway integration using RabbitMQ message queue

This gem is used to communicate to a server Janus through RabbitMQ software
(Message-oriented middleware). It waiting a messages to Rails API who send to
RabbitMQ server in a queue for janus server. janus processes a message and send
 to RabbitMQ server in a queue for gem. Once the received message is decoded
 and returned through the Rails API.

This gem is product by [Dazzl.tv](http://dazzl.tv)

```linux
------------                        ----------                      -------
|Rails Apps|                        |RabbitMQ|                      |Janus|
------------                        ----------                      -------
  |                                   |                                |
  | Request : { "janus": "info" }     |                                |
  | --------------------------------> |                                |
  | Create request json.              |                                |
  | Sending in queue.                 |                                |
  |                                   | -----------------------------> |
  |                                   | Read a message in queue        | ----- |
  |                                   |                                |       | Return a response
  |                                   |                                |       | to treatment executed.
  |                                   |                                | <---- |
  |                                   |                                |
  |                                   |                                |
  |                                   | <----------------------------  |
  | <-------------------------------- |                                |
  |                                   |                                |
  |                                   |                                |
  |                                   |                                |
  |                                   |                                |
```

## Menu
* [How to use](#how-to-use)
  * [Installation](#installation)
  * [Configuration](#configuration)
    * [Generators](#generators)
    * [Requests](#requests)
  * [Usage](#usage)
    * [Information](#usage-information)
    * [Standard request](#standard-request)
    * [Admin request](#admin-request)
    * [Listen Janus Event](#listen-janus-event)
* [Upgrade](#upgrade)
* [Development](#development)
  * [RSpec](#rspec-test)
  * [Documentation](#documentation)
    * [Read documentation](#read-documentation)
    * [Generate developer documentation](#generate-developer-documentation)

## How to use

### Installation

Use rubygem for installing gem in your application. Add in your Gemfile :
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
  ruby_rabbitmq_janus:configuration     # Generate a custom configuration file.
  ruby_rabbitmq_janus:create_request    # Create an request to json format for RubyRabbitmqJanus transaction.
  ruby_rabbitmq_janus:default_request   # Copy base request file sending to janus in application.
  ruby_rabbitmq_janus:initializer       # Generate a initializer to this gem for rails application.
  ruby_rabbitmq_janus:install           # Install RubyRabbitmqJanus in your Rails application
```

#### Requests

For create an new request is simple. Use a command generator :

```ruby
rails g ruby_rabbitmq_janus:create_request test info 'transaction:<string>,body:{plugins:false}'
      create  config/requests/test/info.json
```

For more explain in requests files see [default requests](config/requests.md).

### Usage

#### Usage information

This gem use rabbitmq for manage request sending to Janus, so see
[documentation Janus](https://janus.conf.meetecho.com/docs/pages.html) and
[documentation Rabbitmq](http://www.rabbitmq.com/documentation.html). This gem
use bunny gem for create connection with rabbitmq. See many guide :
[bunny documentation](http://rubybunny.info/articles/guides.html).

#### Standard Request

```ruby
require 'ruby_rabbitmq_janus'

# Initialize standard object
t = RubyRabbitmqJanus::RRJ.new
```

#### Admin Request

```ruby
require 'ruby_rabbitmq_janus'

# Initialize admin object
t = RubyRabbitmqJanus::RRJAdmin.new
```

#### Listen Janus Event

```ruby
require 'ruby_rabbitmq_janus'

# Create a class in your Rails application
actions = RubyRabbitmqJanus::ActionEvents.new.action

# Initialize a thread for listen public queue and send class to thread
RubyRabbitmqJanus::Janus::Concurrencies::Event.instance.run(@actions)
```

## Upgrade

For upgrade your application read [CHANGELOG.md](CHANGELOG.md)

## Development

### RSpec test

```linux
bundle exec rspec
```

TIPS: for rspec install janus and rabbitmq server configured by default for user
rabbitmq and use plugin echotest for janus server.

Use tags for rspec :

| Describe                                                          | Type            | Name            |
| -------------------------------------------------------------     | --------------- | --------------- |
| **Internaly function**                                            | config          |                 |
| Use bunny gem                                                     |                 | rabbit          |
| Test log functions                                                |                 | log             |
| Test configuration function                                       |                 | config          |
| Test Gem contains CONSTANTS                                       |                 | describe        |
| **Level request sending to janus (admin monitor API or classic)** | level           |                 |
| Request with no admin right.                                      |                 | base            |
| Request with admin right in Janus application.                    |                 | admin           |
| **Request JSON sending to Rabbitmq -> Janus**                     | request         |                 |
| Test request attach type                                          |                 | attach          |
| Test request type create                                          |                 | create          |
| Test request type detach                                          |                 | detach          |
| Test request type info                                            |                 | info            |
| Test request type test                                            |                 | test            |

Example usage rspec with tags :
```ruby
rspec --tag --name:config --tag level:base
```

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
