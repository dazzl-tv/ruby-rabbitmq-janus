# frozen_string_literal: true

require 'bundler/setup'
require 'pry'
require 'json-schema-rspec'
require 'rails'
require 'active_record'
require 'ruby_rabbitmq_janus'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Dir['spec/support/**/*.rb'].each do |f|
  require File.expand_path(f)
end

::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each do |f|
  require_relative f
end

RSpec.configure do |config|
  # Configure active record
  configuration = YAML::load(File.open('config/database.yml'))

  # Connect to database
  ActiveRecord::Base.establish_connection(configuration)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include Aruba::Api
  config.include JSON::SchemaMatchers

  # Add JSONs for gem configuration test
  Dir[File.join('spec/support/schemas/config/', '*.json')].count do |file|
    json_file = JSON.parse(File.read(file))
    json_name = File.basename(file, '.json').to_sym
    config.json_schemas[json_name] = json_file
  end

  # Add JSONs for request result test
  Dir[File.join('spec/support/schemas/request/*/', '*.json')].count do |file|
    json_file = JSON.parse(File.read(file))
    json_type = File.dirname(file).split('/').last
    json_name = File.basename(file, '.json').to_sym
    json_index = "#{json_type}::#{json_name}"
    config.json_schemas[json_index] = json_file
  end

  # Configure requests test before sending request
  config.before(:example, level: :base) { gateway }
  config.before(:example, level: :peer) { gateway }
  config.before(:example, level: :admin) { gateway_admin }
  config.before(:example, type: :responses) { gateway }
  config.before(:example, type: :messages) { gateway }
  config.before(:example, name: :admin) { gateway_admin }
  config.before(:example, name: :event) { gateway }
  config.before(:example, name: :standard) { gateway }

  # Exclude request with tag broken
  config.filter_run_excluding broken: true
end

# :reek:UtilityFunction
def singleton
  Singleton.__init__(RubyRabbitmqJanus::Tools::Log)
  Singleton.__init__(RubyRabbitmqJanus::Tools::Config)
  Singleton.__init__(RubyRabbitmqJanus::Tools::Requests)
  Singleton.__init__(RubyRabbitmqJanus::Janus::Concurrencies::Keepalive)
end

def gateway
  singleton
  @gateway = RubyRabbitmqJanus::RRJ.new
  @response = nil
  @options = {}
end

def gateway_admin
  singleton
  @gateway = RubyRabbitmqJanus::RRJAdmin.new
  @response = nil
  @options = {}
end

def gateway_event
  actions = EventTest.new.actions
  @event = RubyRabbitmq::Janus::Concurencies::Event.instance
  @event.run(&actions)
  gateway
end

# Test events response
class EventTest
  def actions
    lambda do |reason, payload|
      p "Reason : #{reason}"
      p "Payload : #{payload}"
    end
  end
end
