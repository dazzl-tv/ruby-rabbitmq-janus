# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a installing
    class InstallGenerator < Rails::Generators::Base
      desc 'Install RubyRabbitmqJanus in your Rails application'

      APPLICATION = <<-AUTOLOAD
  # Load RubyRabbitmqJanus actions events code blocks
  config.autoload_paths += Dir[Rails.root.join('app', 'ruby_rabbitmq_janus')]
      AUTOLOAD

      source_root File.expand_path('templates', __dir__)

      # Generate files with default code
      def add_actions
        # Create an class
        template 'actions.rb', 'app/ruby_rabbitmq_janus/actions.rb'

        # Add to application.rb
        application { APPLICATION }

        # Add initializer
        generate 'ruby_rabbitmq_janus:initializer'

        # Copy basic request
        generate 'ruby_rabbitmq_janus:default_request'
      end
    end
  end
end
