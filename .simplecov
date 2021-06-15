# frozen_string_literal: true

require 'simplecov_json_formatter'

SimpleCov.start do
  # Merge result
  use_merging true

  # Formatter
  formatter SimpleCov::Formatter::JSONFormatter

  # Add branch coverage measurement statistics
  enable_coverage :branch

  # Folders exclude
  add_filter '/errors/'
  add_filter 'lib/rrj/info.rb'
  add_filter '/generators/'
  add_filter '/spec/'
  add_filter '/tasks/'

  # Define groups
  add_group 'Entry Point',    [%w[admin init rails railtie rspec task task_admin].map { |fi| "lib/rrj/#{fi}.rb" }, 'lib/ruby_rabbitmq_janus.rb']
  add_group 'Janus',          'lib/rrj/janus'
  add_group 'Models',         'lib/rrj/models'
  add_group 'Process',        'lib/rrj/process'
  add_group 'RabbitMQ',       'lib/rrj/rabbit'
  add_group 'Tools',          'lib/rrj/tools'
end
