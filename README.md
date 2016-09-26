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
    * [Usage Synchrounous](#usage-with-synchronous-request)
    * [Usage Asynchrounous](#usage-with-asynchronous-request)
    * [Aliases](#aliases)
* [Development](#development)
 * [RSpec](#rspec-test)
 * [Documentation](#documentation)

## How to use

### Installation

Use bitbucket for installing gem in your Gemfile
```ruby
gem 'ruby_rabbitmq_janus'
```

### Configuration

If you want used a customize configuration see [ruby-rabbitmq-janus.yml](config/default.md)

### Usage

#### Usage with synchronous request

Exemple usage simple :
```ruby
# Initialize gem
transaction = RubyRabbitmqJanus::RRJ.new

# Send a message type 'create'
create = transaction.message_template_ask_sync('create')
=> {"janus"=>"create",
 "transaction"=>"U5MZ8IYNLF",
 "correlation"=>"6e77d355-6c3e-450c-89ad-a5daeb8e006a"}
create_response = transaction.message_template_response(create)
=> {"janus"=>"success", "transaction"=>"U5MZ8IYNLF", "data"=>{"id"=>7123088323743398}}

# Destroy session created
destroy = transaction.message_template_ask_sync('destroy')
=> {"janus"=>"destroy",
 "session_id"=>7123088323743398,
 "transaction"=>"PKS63VJD8C",
 "correlation"=>"6e34d8d6-814a-4633-bcab-be3e24cc6260"}
destroy_response = transaction_template_response(destroy)
=> {"janus"=>"success", "session_id"=>7123088323743398, "transaction"=>"PKS63VJD8C"}
```

Example usage with a complex request :
```ruby
# Initialize gem
transaction = RubyRabbitmqJanus::RRJ.new

# Send a request type
transaction.transaction_plugin do |session_running|
  test = transaction.ask_sync('test', session_running)
  session = transaction.response_sync(session_running)
end
```

#### Usage with asynchronous request

Exemple usage simple :

```ruby
# Initialize gem
transaction = RubyRabbitmqJanus::RRJ.new

# Send a message type create
create = transaction.ask_async('create')
=> {"janus"=>"success", "session_id"=>1144864650609378, "transaction"=>"0XGUTFDLBK"}

# Send a message type destroy
transaction.ask_async('destroy', create)
=> {"janus"=>"success", "session_id"=>1144864650609378, "transaction"=>"UPODB8YEG1"}
```

#### Aliases

```ruby
# Aliases to methods synchronous
message_template_ask_sync => ask_sync
message_template_response => response_sync

# Aliases to methods asynchronous
message_template_ask_async => ask_async
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
