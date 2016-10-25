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

    # Send an message simple in current session
    def message_post_for_session(type)
      Rabbit::Connect.new.transaction do |rabbit|
        msg = Janus::Message.new(type, 'session_id' => @session)
        queue_exclusive(rabbit, msg)
      end
    rescue => error
      raise Errors::RRJErrorPost, error
    end

    # Send a message simple for admin Janus
    def message_admin(type)
      Rabbit::Connect.new.transaction do |rabbit|
        msg = Janus::MessageAdmin.new(type, 'session_id' => @session)
        queue_admin(rabbit, msg)
      end
    rescue => error
      raise Errors::RRJErrorPost, error
    end

    # Manage a transaction with an plugin in janus
    # Use a running session for working with janus
    def transaction_complex(type, replace = {}, add = {})
      options = { 'replace' => replace, 'add' => add }
      Janus::Transaction.new(@session).handle_running_complex(type, options)
    end

    # Manage a transaction simple. Just for create element or destroy
    def transaction_simple(type, replace = {}, add = {})
      options = { 'replace' => replace, 'add' => add }
      Janus::Transaction.new(@session).handle_running_simple(type, options)
    end

    # Define an handle and establish connection with janus
    def start_handle
      yield
    rescue => error
      raise Errors::RRJErrorHandle, error
    end

    private

    # Send a simple message in exclusive queue
    def queue_exclusive(rabbit, msg)
      publish = Rabbit::PublishExclusive.new(rabbit.channel, '')
      Janus::Response.new(publish.send_a_message(msg)).to_json
    end

    # Send a simple message in admin queue
    def queue_admin(rabbit, msg)
      publish = Rabbit::PublishAdmin.new(rabbit.channel)
      Janus::Response.new(publish.send_a_message(msg)).to_hash
    end
  end
end
