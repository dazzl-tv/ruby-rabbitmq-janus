# frozen_string_literal: true

module RubyRabbitmqJanus
  module Generators
    # Create an class for generate a initializer
    class InitializerGenerator < Rails::Generators::Base
      desc 'Generate a initializer to this gem for rails application.'

      # Create an initializer
      def copy_initializer
        initializer 'ruby_rabbitmq_janus.rb' do
          <<-INIT
# frozen_string_literal: true

# This test disable this gems execution when you running an task with rake
unless File.basename($PROGRAM_NAME) == 'rake'
  # Write your methods for listening standar queue here
  #
  # Example :
  # action_events = lambda do |reason, data|
  # logger.debug 'Execute block code with reason :'
  # logger.debug reason
  # logger.debug --
  # logger.debug data
  # end

  Rails.configuration.after_initialize do
    # Initialize a gem and create an session with a keepalive
    ::RRJ = RubyRabbitmqJanus::RRJ.new

    # If you want listen a standard queue and execute an block code uncomment
    # this line and craete an method sendind to run
    # ::JEvents = RubyRabbitmqJanus::Janus::Concurrencies::Event.instance
    # JEvents.run(&action_events)
  end
end
          INIT
        end
      end
    end
  end
end
