# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a initializer
    class InitializerGenerator < Rails::Generators::Base
      desc 'Generate a initializer to this gem for rails application.'
      INITIALIZER = <<-INIT
  # frozen_string_literal: true

  require 'actions'

  # Initialize a gem and create an session with a keepalive
  ::RRJ = RubyRabbitmqJanus::RRJ.new

  # For admin management
  # ::RRJ = RubyRabbitmqJanus::RRJAdmin.new

  # This test disable this gems execution when you running an task with rake
  unless File.basename($PROGRAM_NAME) == 'rake'
    Rails.configuration.after_initialize do
      # If you don't want listen a standard queue, comment this lines and
      # "require 'actions'"
      actions = RubyRabbitmqJanus::ActionEvents.new.actions
      RubyRabbitmqJanus::Janus::Concurrencies::Event.instance.run(&actions)
    end
  end
        INIT

      # Create an initializer
      def copy_initializer
        initializer 'ruby_rabbitmq_janus.rb', INITIALIZER
      end
    end
  end
end
