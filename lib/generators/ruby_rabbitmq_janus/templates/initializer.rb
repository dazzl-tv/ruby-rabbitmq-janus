# frozen_string_literal: true

# This test disable this gems execution when you running an task with rake
if File.basename($PROGRAM_NAME) == 'rake'
  # Configure RRJ for rake task
  ::RRJ = RubyRabbitmqJanus::RRJTask.new
else
  # Loading classes Actions to rails application
  require 'actions'

  # If you used gem config for manage your ENV variables uncomment this line
  # @see https://rubygems.org/gems/config
  # Settings.reload!

  # Initialize gem and create a number of session by Janus instance.
  ::RRJ = RubyRabbitmqJanus::RRJ.new

  # Use this initializer if your application use 'Admin/Monitor API'
  # @see https://janus.conf.meetecho.com/docs/admin.html
  # ::RRJ = RubyRabbitmqJanus::RRJAdmin.new

  # Send a block code to thread for manage event given by Janus in public queue
  Rails.configuration.after_initialize do
    # If you don't want listen a standard queue, comment this block and
    # "require 'actions'" also
    actions = RubyRabbitmqJanus::ActionEvents.new.actions
    RubyRabbitmqJanus::Janus::Concurrencies::Event.instance.run(&actions)
  end
end
