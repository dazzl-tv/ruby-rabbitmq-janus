# frozen_string-literal: true

if defined?(ActiveRecord)
  require 'rails/generators/active_record'

  module RubyrabbitmqJanus
    module Generators
      class MigrationGenerator < ::Rails::Generators::Base
        include Rails::Generators::Migration
        desc 'Installs RubyRabbitmqJanus migration file.'

        source_root File.expand_path('../templates', __FILE__)

        def install
          migration_template 'migration.rb',
                             'db/migrate/create_ruby_rabbitmq_janus_tables.rb'
        end

        def self.next_migration_number(dirname)
          ActiveRecord::Generators::Base.next_migration_number(dirname)
        end
      end
    end
  end
end
