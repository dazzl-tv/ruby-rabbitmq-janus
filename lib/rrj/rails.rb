# frozen_string_literal: true

require 'rails'
require 'action_view'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

  # # Rails
  #
  # Use option to rails for prepapre application with RRJ.
  # Initialize public queue to janus instance.
  class Rails < ::Rails::Engine
    config.after_initialize do
      Log.debug '[RRJ] After initializer'
      require File.join(Dir.pwd,
                        RubyRabbitmqJanus::Tools::Config.instance.listener_path)

      Log.info 'Listen public queue in thread'
      actions = RubyRabbitmqJanus::ActionEvents.new.actions
      RubyRabbitmqJanus::Process::Concurrencies::Event.instance.run(&actions)
    end
  end
end

require ::File.expand_path('config/environment', Dir.pwd)
