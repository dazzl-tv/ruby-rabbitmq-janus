# frozen_string-literal: true

module RubyRabbitmqJanus
  module Generators
    require 'rails/generators/active_record'

    class MigrationGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      desc 'Add to rails project RubyRabbitmqJanus migration file.'

      source_root File.expand_path('../templates', __FILE__)

      def install
        migration_template 'migration.rb',
                           'db/migrate/create_ruby_rabbitmq_janus_tables.rb'
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end
    end if defined?(ActiveRecord) && !defined?(Mongo)
  end
end
