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
      actions = ActionEvents.new.actions
      admin_actions = ActionAdminEvents.new.actions

      listeners = []
      (1..number).each do
        listeners.push process::Event.new.run(&actions)
        listeners.push process::EventAdmin.new.run(&admin_actions)
      end

      Parallel.each(listeners, in_processes: number) do |listener|
        item = "[Item##{listener}]"
        Log.warn "#{item}, Worker : #{Parallel.worker_number + 1} / #{number}"
      end
    end
  end
end

require ::File.expand_path('config/environment', Dir.pwd)
