# ruby-rabbitmq-janus
Ruby Gem for Janus WebRTC Gateway integration using RabbitMQ message queue

This gem is used to communicate to a server Janus through RabbitMQ software (
Message-oriented middleware). It waiting a messages to Rails API who send to RabbitMQ
server in a queue for janus server. janus processes a message and send to RabbitMQ server
in a queue for gem. Once the received message is decoded and returned through the Rails API.

## Menu
* [How to use](#how-to-use)
 * [Installation](#installation)
 * [Configuration](#configuration)
 * [Usage](#usage)
* [Development](#development)
 * [RSpec](#rspec-test)
 * [Documentation](#documentation)

## How to use

### Installation

Use bitbucket for installing gem in your Gemfile
```ruby
gem 'ruby-rabbitmq-janus', '~> 0.1.0'
```

### Configuration

If you want used a customize configuration see [ruby-rabbitmq-janus.yml](config/default.md)

### Usage

Exemple usage :
```ruby
# Initialize gem
transaction = RRJ::RRJ.new

# Send a message type 'create'
create = transaction.message_template_ask('create')
=> {"janus"=>"create",
 "transaction"=>"U5MZ8IYNLF",
 "correlation"=>"6e77d355-6c3e-450c-89ad-a5daeb8e006a"}
create_response = transaction.message_template_response(create)
=> {"janus"=>"success", "transaction"=>"U5MZ8IYNLF", "data"=>{"id"=>7123088323743398}}

# Destroy session created
destroy = transaction.message_template_ask('destroy')
=> {"janus"=>"destroy",
 "session_id"=>7123088323743398,
 "transaction"=>"PKS63VJD8C",
 "correlation"=>"6e34d8d6-814a-4633-bcab-be3e24cc6260"}
destroy_response = transaction_template_response(destroy)
=> {"janus"=>"success", "session_id"=>7123088323743398, "transaction"=>"PKS63VJD8C"}
```

The methods message_template_ask and message_template_response have an aliases :wink:
```ruby
message_template_ask => ask
message_template_response => response
```

## Development
### RSpec test

```linux
bundle exec rspec
```

TIPS: for rspec install janus and rabbitmq server configured by default for user
 rabbitmq and use plugin echotest for janus server.

### Documentation

This doc is generated with yard.

```
# Genereate doc
yard
# Launch server
yard server
```

see [Yard Getting Started](http://www.rubydoc.info/gems/yard/file/docs/GettingStarted.md)
