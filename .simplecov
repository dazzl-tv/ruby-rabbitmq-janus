# frozen_string_literal: true

SimpleCov.start do
  # Add branch coverage measurement statistics
  enable_coverage :branch

  formatter SimpleCov::Formatter::HTMLFormatter

  # Folders exclude
  add_filter '/errors/'
  add_filter 'lib/rrj/info.rb'
  add_filter '/generators/'
  add_filter '/spec/'
  add_filter '/tasks/'

  # Define groups
  add_group 'Entry Point', [
    %w[admin init rails railtie rspec task task_admin].map do |fi|
      "lib/rrj/#{fi}.rb"
    end,
    'lib/ruby_rabbitmq_janus.rb'
  ]
  add_group 'Janus',          'lib/rrj/janus'
  add_group 'Models',         'lib/rrj/models'
  add_group 'Process',        'lib/rrj/process'
  add_group 'RabbitMQ',       'lib/rrj/rabbit'
  add_group 'Tools',          'lib/rrj/tools'
end
