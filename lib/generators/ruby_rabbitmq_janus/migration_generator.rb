# frozen_string-literal: true

# :reek:IrresponsibleModule

module RubyRabbitmqJanus
  # Module for generators
  module Generators
    if defined?(ActiveRecord) && !defined?(Mongo)
      # Create a migration for rails project with active record
      class MigrationGenerator < ::Rails::Generators::Base
        require 'rails/generators/active_record'

        include Rails::Generators::Migration

        desc 'Add to rails project RubyRabbitmqJanus migration file.'

        source_root File.expand_path('templates', __dir__)

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
