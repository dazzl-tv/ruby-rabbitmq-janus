# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a custom configuration file
    class ConfigurationGenerator < Rails::Generators::Base
      desc 'Generate a custom configuration file.'

      def self.source_root
        root_path = File.realpath(File.join(File.dirname(__FILE__), '..', '..', '..'))
        @_rrj_source_root ||= File.join(root_path, 'config')
      end

      def copy_initializer
        template 'default.yml', 'config/ruby-rabbitmq-janus.yml'
      end
    end
  end
end
