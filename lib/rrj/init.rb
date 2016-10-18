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
require 'colorize'

module RubyRabbitmqJanus
  # @author VAILLANT Jeremy <jeremy.vaillant@dazzl.tv>
  # Initialize gem and create automatically an session with Janus
  # @!attribute [r] session
  class RRJ
    attr_reader :session

    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      Tools::Log.instance
      Tools::Config.instance
      Tools::Requests.instance

      @session = Janus::Keepalive.new.session
    end

    # Send a simple message to janus
    # This method smells of :reek:UtilityFunction
    def message_post(type = 'info')
      Tools::Log.instance.warn "Send a simple message : #{type}"
      Rabbit::Connect.new.transaction do |rabbit|
        publish = Rabbit::PublishExclusive.new(rabbit.channel, '')
        resp = publish.send_a_message(Janus::Message.new(type))
        Janus::Response.new(resp).to_json
      end
    end

    # Manage a transaction with an plugin in janus
    # Use a running session for working with janus
    def transaction(type, replace = {}, add = {})
      Tools::Log.instance.debug 'Transaction a started'
      options = { 'replace' => replace, 'add' => add }
      tran = Janus::Transaction.new(@session)
      tran.handle_running(type, options)
    end

    # Define an handle and establish connection with janus
    def start_handle(reason, data, jsep = nil)
      Tools::Log.instance.debug 'Create an handle and establish an connection with janus'
      tran = Janus::Transaction.new(@session)
      tran.handle_running(type, options)
      tran.sending_message(reason, data, jsep)
    end
  end
end
