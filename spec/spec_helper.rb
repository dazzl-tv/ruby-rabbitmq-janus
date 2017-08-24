# frozen_string_literal: true

require 'bundler/setup'
require 'pry'
require 'json-schema-rspec'
require 'rails'
require 'database_cleaner'
ENV['MONGO']='true' if ENV['MONGO'].nil?
require ENV['MONGO'].match?('true') ? 'mongoid' : 'active_record'

require 'ruby_rabbitmq_janus'
require 'config/initializer'
require 'config/database'
require 'config/instance'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Dir['spec/support/**/*.rb'].each do |f|
  require File.expand_path(f)
end

::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each do |f|
  require_relative f
end

RSpec.configure do |config|
  DatabaseCleaner.strategy = :truncation
  ENV['MONGO'].match?('true') ? load_mongo : load_active_record
  after_load_database

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

  # Exclude request with tag broken
  config.filter_run_excluding broken: true

  config.before(:example) do |example|
    @gateway = if example.metadata[:level]
                 RubyRabbitmqJanus::RRJAdmin.new
               else
                 RubyRabbitmqJanus::RRJ.new
               end

    ji = RubyRabbitmqJanus::Models::JanusInstance.first
    @response = nil
    @options = {}
    @session = { 'session_id' => ji.session }
    @instance = { 'instance' => ji.instance }
    @session_instance = @session.merge(@instance)
  end
end
