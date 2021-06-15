# frozen_string_literal: true

require 'simplecov'

# Load gems dependencies
require 'bundler/setup'
require 'pry'
require 'json-schema-rspec'
require 'rails'
require 'factory_bot'
ENV['MONGO'] = 'true' if ENV['MONGO'].nil?
if ENV['MONGO'] == 'true'
  require 'mongoid'
  require 'database_cleaner/mongoid'
else
  require 'active_record'
  require 'database_cleaner/active_record'
end
# require ENV['MONGO'].match?('true') ? 'mongoid' : 'active_record'
require 'timeout'

# Load gem RubyRabbitmqJanus
require 'ruby_rabbitmq_janus'

# Configure application for testing
require 'config/initializer'
require 'config/database'

require 'aruba/rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

Dir['spec/support/**/*.rb'].each do |f|
  require File.expand_path(f)
end

::Dir.glob(::File.expand_path('../support/**/*.rb', __dir__)).each do |f|
  require_relative f
end

RSpec.configure do |config|
  config.fail_fast = if ENV.key?('SPEC_DEBUG')
                       ENV['SPEC_DEBUG'].match?('true')
                     else
                       false
                     end
  ENV['MONGO'].match?('true') ? load_mongo : load_active_record

  config.expect_with :rspec do |c|
    c.syntax = :expect
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-contexty
  config.shared_context_metadata_behavior = :apply_to_host_groups

  # config.include Aruba::Api
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

  # Configure Factory Girl
  config.include FactoryBot::Syntax::Methods

  # Load factory bot definition
  config.before(:suite) do
    FactoryBot.find_definitions
  end

  # Clean database before execute an example
  DatabaseCleaner.strategy = ENV['MONGO'] == 'true' ? :deletion : :truncation
  config.before do |example|
    after_load_database unless example.metadata[:type].match?(/tools/)
  end

  # Use timeout for requester
  config.around(:each, type: :request) do |example|
    Timeout.timeout(5) { example.run }
  end
end
