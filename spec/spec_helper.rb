# frozen_string_literal: true

unless ENV['TRAVIS'].eql?('true')
  require 'simplecov'

  SimpleCov.start do
    # Folders exclude
    add_filter '/errors/'
    add_filter 'lib/rrj/info.rb'
    add_filter '/generators/'
    add_filter '/spec/'
    add_filter '/tasks/'

    # Path for result
    coverage_dir 'tmp/coverage'

    # Define groups
    add_group 'Entry Point',    [%w[admin init rails railtie rspec task task_admin].map { |fi| "lib/rrj/#{fi}.rb" }, 'lib/ruby_rabbitmq_janus.rb']
    add_group 'Janus',          'lib/rrj/janus'
    add_group 'Models',         'lib/rrj/models'
    add_group 'Process',        'lib/rrj/process'
    add_group 'RabbitMQ',       'lib/rrj/rabbit'
    add_group 'Tools',          'lib/rrj/tools'

    # Merge result
    use_merging true
  end
end

# Load gems dependencies
require 'bundler/setup'
require 'pry'
require 'json-schema-rspec'
require 'rails'
require 'factory_bot'
require 'database_cleaner'
ENV['MONGO'] = 'true' if ENV['MONGO'].nil?
require ENV['MONGO'].match?('true') ? 'mongoid' : 'active_record'
require 'timeout'
require 'rspec/retry'

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
  DatabaseCleaner.strategy = :truncation
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

  # Configure Initializer RRJ and create session with Janus Instance
  config.before do |example|
    # rubocop:disable Performance/StringInclude
    after_load_database unless example.metadata[:type].match?(/tools/)
    # rubocop:enable Performance/StringInclude
  end

  # Use timeout for requester
  config.around(:each, type: :request) do |example|
    Timeout.timeout(5) { example.run }
  end

  # show retry status in spec process
  config.verbose_retry = true
  # show exception that triggers a retry if verbose_retry is set to true
  config.display_try_failure_messages = true
end
