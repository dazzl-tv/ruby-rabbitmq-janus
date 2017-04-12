# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a installing
    class InstallGenerator < Rails::Generators::Base
      desc 'Install RubyRabbitmqJanus in your Rails application'
      ACTION_CLASS = <<-BASE
  module RubyRabbitmqJanus
    # Execute this code when janus return an events in standard queue
    class ActionsEvents
      # Default method using for sending a block of code
      def actions
        lambda do |reason, data|
          Rails.logger.debug "Execute block code with reason : \#{reason}"
          case reason
          when event this case_events(data.to_hash)
          end
        end
      end

      private

      def case_events(data)
        Rails.logger.debug "Event : \#{data}"
      end
    end
  end
      BASE
      APPLICATION = <<-AUTOLOAD
  # Load RubyRabbitmqJanus actions events code blocks
  config.autoload_paths += Dir[Rails.root.join('app', 'ruby_rabbitmq_janus')]
      AUTOLOAD

      # Generate initializer with default code
      def add_actions
        # Create an class
        create_file 'app/ruby_rabbitmq_janus/actions.rb', ACTION_CLASS

        # Add to application.rb
        application do
          APPLICATION
        end

        # Add initializer
        generate 'ruby_rabbitmq_janus:initializer'

        # Copy basic request
        generate 'ruby_rabbitmq_janus:default_request'
      end
    end
  end
end
