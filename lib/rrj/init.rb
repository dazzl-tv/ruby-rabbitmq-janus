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
  # :reek:BooleanParameter
  class RRJ
    attr_reader :session

    # Returns a new instance of RubyRabbitmqJanus
    def initialize
      Tools::Log.instance
      Tools::Config.instance
      Tools::Requests.instance

      @session = Janus::Keepalive.new.session

      @transaction = nil
    rescue => error
      raise Errors::RRJErrorInit, error
    end

    # Send an simple message to janus. No options in request with this method.
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    # @exemple Sending an message info
    #   RubyRabbitmqJanus::RRJ.new.message_simple('base::info')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    # @return [RubyRabbitmqJanus::Janus::Response] Give an object response to janus server
    def message_simple(type, exclusive = false)
      Janus::Transaction.new(@session).connect(exclusive) do
        Janus::Message.new(type)
      end
    end

    # Send an message simple in current session.
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Options update in request
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    # @exemple Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_session('base::create')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    # @return [RubyRabbitmqJanus::Janus::Response] Give an object response to janus server
    def message_session(type, options = {}, exclusive = false)
      Janus::TransactionSession.new(@session).session_connect(exclusive) do
        Janus::Message.new(type, use_current_session?(options))
      end
    rescue => error
      raise Errors::RRJErrorPost, error
    end

    # Send a message simple for admin Janus
    def message_admin(type, options = {})
      Janus::TransactionAdmin.new(@session).connect do
        Janus::MessageAdmin.new(type, options.merge!('session_id' => @session))
      end
      # msg = Janus::MessageAdmin.new(type, options.merge!('session_id' => @session))
      # queue_admin(rabbit, msg)
    end

    # Send an message in handle session in current session.
    # @param [String] type
    #   Given a type to request. JSON request writing in 'config/requests/'
    # @param [Hash] options Options update in request
    # @param [Bollean] exclusive
    #   Use an exclusive queue or not
    # @exemple Sending an message create
    #   RubyRabbitmqJanus::RRJ.new.message_session('base::create')
    #   #=> {"janus":"server_info","name":"Janus WebRTC Gateway" ... }
    # @return [RubyRabbitmqJanus::Janus::Response] Give an object response to janus server
    def message_handle(type, replace = {}, add = {})
      options = { 'replace' => replace, 'add' => add }
      Tools::Log.instance.debug "Transaction : #{@transaction}"
      @transaction.publish_message_handle(type, options)
    end

    # Manage a transaction simple. Just for create element or destroy
    # def transaction_simple(type, replace = {}, add = {})
    #   options = { 'replace' => replace, 'add' => add }
    #   Janus::Transaction.new(@session).handle_running_simple(type, options)
    # end

    # Define an handle and establish connection with janus
    def start_handle(exclusive = false)
      @transaction = Janus::TransactionHandle.new(@session)
      @transaction.handle_connect(exclusive) { yield }
    rescue => error
      raise Errors::RRJErrorHandle, error
    end

    def start_handle_admin
      @transaction = Janus::TransactionAdmin.new(@session)
      @transaction.handle_connect { yield }
    rescue => error
      raise Errors::RRJErrorHandle, error
    end

    # Stop an handle existing in session running
    def stop_handle
      @transaction.handle_running_stop
    end

    private

    # Send a simple message in exclusive queue
    def queue_exclusive(rabbit, msg)
      publish = Rabbit::PublishExclusive.new(rabbit.channel, '')
      Janus::Response.new(publish.send_a_message(msg)).to_json
    end

    # Return a current session if not specified
    def use_current_session?(option)
      { 'session_id' => @session } unless option.key?('session_id')
    end
  end
end
