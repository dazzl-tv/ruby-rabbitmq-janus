# frozen_string_literal: true

module RubyRabbitmqJanus
  # Module for generators
  module Generators
    # Create an class for generate a custom configuration file
    class ConfigurationGenerator < Rails::Generators::Base
      desc 'Generate a custom configuration file.'

      # Define root path for original file a copied
      source_root File.expand_path('../../../config', __dir__)

      # Copy a default configuration in config folder to Rails app
      def copy_configuration
        template 'default.yml', 'config/ruby-rabbitmq-janus.yml'
      end
    end
  end
end
