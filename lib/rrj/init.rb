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
    rescue => error
      raise Errors::RRJErrorInit, error
    end

    # Send a simple message to janus
    # This method smells of :reek:UtilityFunction
    def message_post(type = 'info')
      Rabbit::Connect.new.transaction do |rabbit|
        publish = Rabbit::PublishExclusive.new(rabbit.channel, '')
        Janus::Response.new(publish.send_a_message(Janus::Message.new(type))).to_json
      end
    rescue => error
      raise Errors::RRJErrorPost, error
    end

    # Manage a transaction with an plugin in janus
    # Use a running session for working with janus
    def transaction(type, replace = {}, add = {})
      options = { 'replace' => replace, 'add' => add }
      tran = Janus::Transaction.new(@session)
      tran.handle_running(type, options)
    rescue => error
      raise Errors::RRJErrorTransaction, error
    end

    # Define an handle and establish connection with janus
    def start_handle
      # tran = Janus::Transaction.new(@session)
      # tran.sending_message yield
      yield
    rescue => error
      raise Errors::RRJErrorHandle, error
    end
  end
end
