# frozen_string_literal: true

module RubyRabbitmqJanus
  # Module for generators
  module Generators
    # Create an class for generate a custom configuration file
    class ConfigurationGenerator < Rails::Generators::Base
      desc 'Generate a custom configuration file.'

      # Define root path for original file a copied
      def self.source_root
        root_path = File.realpath(root_path_gem)
        @_rrj_source_root ||= File.join(root_path, 'config')
      end

      # Copy a default configuration in config folder to Rails app
      def copy_configuration
        template 'default.yml', 'config/ruby-rabbitmq-janus.yml'
      end

      private

      # Define a root path
      def root_path_gem
        File.join(File.dirname(__FILE__), '..', '..', '..')
      end
    end
  end
end
