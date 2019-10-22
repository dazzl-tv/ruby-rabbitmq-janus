# frozen_string_literal: true

require 'rails'
require 'action_view'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>

  # # Rails
  #
  # Use option to rails for prepare application with RRJ.
  # Initialize public queue to Janus instance.
  class Rails < ::Rails::Engine
    config.after_initialize do
      Log.debug '[RRJ] After initializer'
      cfg = RubyRabbitmqJanus::Tools::Config.instance

      require File.join(Dir.pwd, cfg.listener_path)
      require File.join(Dir.pwd, cfg.listener_admin_path)

      process = RubyRabbitmqJanus::Process::Concurrencies

      Log.info '[RRJ] Listen public queue in thread'
      actions = RubyRabbitmqJanus::ActionEvents.new.actions
      process::Event.instance.run(&actions)

      Log.info '[RRJ] Listen admin queue in thread'
      admin_actions = RubyRabbitmqJanus::ActionAdminEvents.new.actions
      process::EventAdmin.instance.run(&admin_actions)
    end
  end
end

require ::File.expand_path('config/environment', Dir.pwd)
