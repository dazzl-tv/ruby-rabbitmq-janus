# frozen_string_literal: true

action_event_path = "#{Dir.pwd}/#{LISTENER_PATH}"
Log.debug "Load action events to path : #{action_event_path}"
require action_event_path
require 'rrj/tools/gem/config'
require 'rrj/models/concerns/janus_instance_callbacks'
require 'rrj/models/concerns/janus_instance_methods'
require 'rrj/models/concerns/janus_instance_validations'
require "rrj/models/#{defined?(Mongoid) ? 'mongoid' : 'active_record'}"

module RubyRabbitmqJanus
  # :reek:InstanceVariableAssumption

  # # RubyRabbitmqJanus Bynary
  #
  # Initialize tools for a standalone executable
  # This class start all tool mandatory for
  # survey new message about JanusInstance change state.
  #
  # When status enable change update document in database
  # if enable become true a new session with janus is created
  class Binary
    def initialize
      RubyRabbitmqJanus::Tools::Config.instance

      start_instances
    end

    def update_instance(data)
      enable = data['enable']
      @ji = RubyRabbitmqJanus::Models::JanusInstance.find(data['id'])

      ::Log.info 'Update Janus Instance ...'
      enable ? start_instance : stop_instance
    end

    private

    def start_instances
      ::Log.info 'Search Janus Instance'
      instances = RubyRabbitmqJanus::Models::JanusInstance.enabled

      ::Log.info "Find [#{instances.count}] instance(s) enable"
      instances.each(&:create_keepalive) unless instances.empty?
    end

    def start_instance
      ::Log.info "... create a session to Janus Instance with id : #{@ji.id}"
      @ji.create_keepalive
    end

    def stop_instance
      ::Log.info "... stop a session to Janus Instance with ID : #{@ji.id}"
      @ji.stop_keepalive
    end
  end
end
