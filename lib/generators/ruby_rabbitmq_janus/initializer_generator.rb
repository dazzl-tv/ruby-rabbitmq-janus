# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a initializer
    class InitializerGenerator < Rails::Generators::Base
      desc 'Generate a initializer to this gem for rails application.'

      source_root File.expand_path('templates', __dir__)

      # Create an initializer
      def copy_initializer
        copy_file 'initializer.rb', 'config/initializers/ruby_rabbitmq_janus.rb'
      end
    end
  end
end
