# frozen_string_literal: true

# Select ORM between Mongoid and ActiveRecord

require ORM
Mongoid.load!(File.join(Dir.pwd, 'config', 'mongoid.yml'), ENVIRONMENT) \
  if defined?(Mongoid)
