# frozen_string_literal: true

# Define methods for checking program is started.
# Is useless if your are a standalone program (just rails)
#
# Don't forgotten to add variable environment to your program.
#
# Methods for getting program name, test if rails/sidekiq/rrj ...
module Rails
  # Check if application instance is a console rails
  def self.console?
    defined?(::Rails::Console)
  end

  # Get variable name PROGRAM_NAME
  # Don't use Config gem, it's loaded after this module
  def self.pg_name
    File.basename($PROGRAM_NAME) || ENV['PROGRAM_NAME']
  end

  # Check if application instance is Rails
  def self.pg_rails?
    PROGRAM.eql?('rails')
  end

  # Check if application instance is Sidekiq
  def self.pg_sidekiq?
    PROGRAM.eql?('sidekiq')
  end

  # Check if application instance is RubyRabbitmqJanus
  def self.pg_rrj?
    PROGRAM.eql?('ruby_rabbitmq_janus')
  end

  # Determine constant value for application instance
  PROGRAM = console? ? 'console' : pg_name
end


# If you used gem config for manage your ENV variables uncomment this line
# @see https://rubygems.org/gems/config
Settings.reload!

::RRJ = case Rails::PROGRAM
        when 'console', 'rake'
          # Don't listen events in public queue to RabbitMQ.
          # A thread exist with program application instance.
          #
          # Use this configuration if start rails console,
          # rake or a sidekiq service.
          RubyRabbitmqJanus::RRJTaskAdmin.new
        when 'rspec'
          # Use Bunny Mock gem. Is used with pipeline bitbucket.
          RubyRabbitmqJanus::RRJRSpec.new
        when 'sidekiq', 'rails', 'ruby_rabbitmq_janus'
          # Reload env variable before start thread RRJ for
          # listen events in RabbitMQ public queue.
          # Load class manually.
          # It's loaded after initializer so add manually here the listener block.
          RubyRabbitmqJanus::RRJAdmin.new

          # Comment/Remove this line if RRJ listener public queue is executed
          # in another container/program
          #
          # Loading classes Actions to rails application
          require 'actions'

          # Send a block code to thread for manage event given by Janus in public queue
          Rails.configuration.after_initialize do
            # If you don't want listen a standard queue, comment this block and
            # "require 'actions'" also
            actions = RubyRabbitmqJanus::ActionEvents.new.actions
            RubyRabbitmqJanus::Janus::Concurrencies::Event.instance.run(&actions)
          end
        end
