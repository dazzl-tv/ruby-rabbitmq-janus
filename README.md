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

Exemple usage :
```ruby
# Send a message type 'info'
info = RRJ::RRJ.new
info.rabbit.send_message(:info)
```

```json
# Result log
{
  "janus": "server_info",
  "transaction": "M37VTSI5XN",
  "name": "Janus WebRTC Gateway",
  "version": 12,
  "version_string": "0.1.2",
  "author": "Meetecho s.r.l.",
  "log-to-stdout": "true",
  "log-to-file": "false",
  "data_channels": "true",
  "server-name": "MyJanusInstance",
  "local-ip": "172.19.0.4",
  "ipv6": "false",
  "ice-tcp": "false",
  "api_secret": "false",
  "auth_token": "false",
  "transports": {
    "janus.transport.rabbitmq": {
      "name": "JANUS RabbitMQ transport plugin",
      "author": "Meetecho s.r.l.",
      "description": "This transport plugin adds RabbitMQ support to the Janus API via rabbitmq-c.",
      "version_string": "0.0.1",
      "version": 1
    },
    "janus.transport.http": {
      "name": "JANUS REST (HTTP/HTTPS) transport plugin",
      "author": "Meetecho s.r.l.",
      "description": "This transport plugin adds REST (HTTP/HTTPS) support to the Janus API via libmicrohttpd.",
      "version_string": "0.0.2",
      "version": 2
    },
    "janus.transport.websockets": {
      "name": "JANUS WebSockets transport plugin",
      "author": "Meetecho s.r.l.",
      "description": "This transport plugin adds WebSockets support to the Janus API via libwebsockets.",
      "version_string": "0.0.1",
      "version": 1
    },
    "janus.transport.pfunix": {
      "name": "JANUS Unix Sockets transport plugin",
      "author": "Meetecho s.r.l.",
      "description": "This transport plugin adds Unix Sockets support to the Janus API.",
      "version_string": "0.0.1",
      "version": 1
    }
  },
  "plugins": {
    "janus.plugin.dazzl.videocontrol": {
      "name": "DAZZL Video Control Room plugin for Janus",
      "author": "Laurent Cogné",
      "description": "This is a plugin implementing a video control room for Janus, that is an audio/video router.",
      "version_string": "0.0.1",
      "version": 1
    },
    "janus.plugin.textroom": {
      "name": "JANUS TextRoom plugin",
      "author": "Meetecho s.r.l.",
      "description": "This is a plugin implementing a text-only room for Janus, using DataChannels.",
      "version_string": "0.0.2",
      "version": 2
    }
  }
}
```

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
