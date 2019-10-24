# frozen_string_literal: true

require 'rails'
require 'action_view'
require 'parallel'

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
      number = cfg.public_queue_process

      require File.join(Dir.pwd, cfg.listener_path)
      require File.join(Dir.pwd, cfg.listener_admin_path)

      Log.debug "[RRJ] Create process : #{number}"
      process = RubyRabbitmqJanus::Process::Concurrencies
      actions = RubyRabbitmqJanus::ActionEvents.new.actions
      admin_actions = RubyRabbitmqJanus::ActionAdminEvents.new.actions

      Parallel.map([
                     process::Event.new.run(&actions),
                     process::EventAdmin.new.run(&admin_actions)
                   ], in_processes: number) do |listener|
        "Item: #{listener}, Worker: #{Parallel.worker_number}"
      end
    end
  end
end

require ::File.expand_path('config/environment', Dir.pwd)
