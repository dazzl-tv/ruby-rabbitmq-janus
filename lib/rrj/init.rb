# frozen_string_literal: true

require 'singleton'
require 'yaml'
require 'json'
require 'securerandom'
require 'bunny'
require 'logger'
require 'key_path'
require 'active_support'
require 'concurrent'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem and create automatically an session with Janus
  # @!attribute [r] session
  class RRJ
    attr_reader :session

    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      Log.instance
      Config.instance
      Requests.instance

      @session = Keepalive.new.session
    end

    # Send a simple message to janus
    # This method smells of :reek:UtilityFunction
    def message_post(type = 'info')
      Log.instance.warn "Send a simple message : #{type}"
      Rabbit::Connect.new.transaction do |rabbit|
        publish = Rabbit::PublishExclusive.new(rabbit.channel, '')
        RubyRabbitmqJanus::Response.new(publish.send_a_message(Message.new(type))).to_json
      end
    end

    # Manage a transaction with an plugin in janus
    # Use a running session for working with janus
    def transaction(type, options = {})
      Log.instance.debug 'Transaction a started'
      tran = Transaction.new(@session)
      tran.handle_running(type, options)
    end
  end
end
