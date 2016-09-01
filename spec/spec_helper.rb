# frozen_string_literal: true
#
require 'bundler/setup'
require 'rrj'
require 'pry'
require 'json-schema-rspec'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

Dir['spec/support/**/*.rb'].each do |f|
  require File.expand_path(f)
end

::Dir.glob(::File.expand_path('../support/**/*.rb', __FILE__)).each do |f|
  require_relative f
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.include Aruba::Api
  config.include JSON::SchemaMatchers

  Dir[File.join('spec/support/schemas/', '*.json')].count do |file|
    config.json_schemas[File.basename(file, '.json').to_sym] = file
  end
end
