# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a custom configuration file
    class InitializerGenerator < Rails::Generators::Base
      desc 'Generate a initializer to this gem for rails application.'

      def self.source_root
        root_path = File.realpath(File.join(File.dirname(__FILE__), '..', '..', '..'))
        @_rrj_source_root ||= File.join(root_path, 'config')
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/ruby_rabbitmq_janus.rb'
      end
    end
  end
end
