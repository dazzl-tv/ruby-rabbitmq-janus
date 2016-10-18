# frozen_string_literal: true

# Module contains all lib to this gem
module RubyRabbitmqJanus
  # Module for generators
  module Generators
    # Create an class for generate a custom configuration file
    class ConfigurationGenerator < Rails::Generators::Base
      desc 'Generate a custom configuration file.'

      # Define root path for original file a copied
      def self.source_root
        root_path = File.realpath(File.join(File.dirname(__FILE__), '..', '..', '..'))
        @_rrj_source_root ||= File.join(root_path, 'config')
      end

      # Copy a default configuration in config folder to Rails app
      def copy_configuration
        template 'default.yml', 'config/ruby-rabbitmq-janus.yml'
      end
    end
  end
end
